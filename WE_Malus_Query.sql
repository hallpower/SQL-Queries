/* 
This query takes holidays in between two dates into account.
*/
with malus_data as
(
select	ph.No_ as PO
		, ph.[Group7 Reference] as Lieferschein
		, ph.[Entry No_]
		, pl.[Line No_]
		, we.Lieferdatum as WE_Datum
		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as WE_Datum_Adj
		, DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
		, we.Lieferzeit as WE_Zeit
		, cast(ph.[Posting Date] as date) as Buchungsdatum
		, pl.No_ as SKU
		, pl.Quantity as Anzahl
		, datediff(dd, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), ph.[Posting Date]) + CASE
                                   WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 7 THEN 1
                                   ELSE 0
                               END - (datediff(wk, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), ph.[Posting Date]) * 2) - CASE
                                                                        WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 1 THEN 1
                                                                        ELSE 0
                                                                    END + CASE
                                                                              WHEN datepart(dw, ph.[Posting Date]) = 1 THEN 1
                                                                              ELSE 0
                                                                          END + 1 -
                                                                          (select count(*) from BI_Data.dbo.Holidays_Bradenburg 
                                      where HolidayDate 
                                        between cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) 
                                        and ph.[Posting Date])
                                                                          as Date_Diff
        , CASE 
            WHEN we.bemerkung LIKE ('%icket%') THEN we.bemerkung
            WHEN ph.[Your Reference] LIKE ('%icket%') THEN ph.[Your Reference] collate Latin1_General_100_CS_AS
            WHEN we.bemerkung like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN we.bemerkung
            WHEN ph.[Your Reference] like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN ph.[Your Reference] collate Latin1_General_100_CS_AS
            WHEN we.bemerkung LIKE('%Kl.rung%') THEN we.bemerkung
            WHEN ph.[Your Reference] LIKE('%Kl.rung%') THEN ph.[Your Reference] collate Latin1_General_100_CS_AS
            ELSE ' ' END as Ticket
from Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFPurchaseHeader] ph with (nolock)
join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFPurchaseLine] pl with (nolock)
	on pl.[Document No_] = ph.No_
left join [BI_Data].[dbo].[we] we with (nolock)
	on we.PoNummer = ph.[No_] collate Latin1_General_100_CS_AS
    and we.Lieferschein = ph.[Group7 Reference] collate Latin1_General_100_CS_AS
-- where ph.[Entry No_] > 1
where pl.[Document Entry No_] = 2
and ph.Type = 1
and ph.[Location Code] = 'BER_FIEGE'
and ph.[Posting Date] between '2014-06-01' and '2014-06-30'
),
we_adj as
(
select	DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as WE_Datum_Adj
		, sum(pl.Quantity) as Anzahl
from Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFPurchaseHeader] ph with (nolock)
join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFPurchaseLine] pl with (nolock)
	on pl.[Document No_] = ph.No_
left join [BI_Data].[dbo].[we] we with (nolock)
	on we.PoNummer = ph.[No_] collate Latin1_General_100_CS_AS
    and we.Lieferschein = ph.[Group7 Reference] collate Latin1_General_100_CS_AS
where pl.[Document Entry No_] = 2
and ph.Type = 1
and ph.[Location Code] = 'BER_FIEGE'
and we.Lieferdatum >= '2014-01-01'
group by DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum))
		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)
)
,
sla_data as (
select	KW
		, WE_Datum_Adj
		, cast (Anzahl as int) as Anzahl
		, cast(Anzahl / SUM(Anzahl) over ( Partition by KW) as decimal(5,2)) as pct_of_wk
		, case when Anzahl / SUM(Anzahl) over ( Partition by KW) < 0.25 then 2 else 3 end as SLA
from we_adj
)

select 	malus_data.*
		, sla_data.SLA
		, case 	when len(malus_data.Ticket) > 2 then 0
				when malus_data.Date_Diff > sla_data.SLA then malus_data.Anzahl
				else 0 END as Malus
from malus_data
join sla_data
on sla_data.WE_Datum_Adj = malus_data.WE_Datum_Adj
order by malus_data.PO
		, malus_data.Lieferschein
		, malus_data.[Entry No_]
		, malus_data.[Line No_]