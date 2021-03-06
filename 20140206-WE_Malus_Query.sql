/****** 
WE Malus Query

To-Do:
- Add Holidays to Date_Diff
- Add Tickets from WE
- Add Tickets from OTRS
- Add SLA to determine Malus

******/

Declare @from date = '2014-01-01'
Declare @to date = '2014-01-31';

with WE as
(SELECT 
case 
when Lieferschein = ' ' then PoNummer
else PoNummer + Lieferschein 
end collate Latin1_General_CI_AS as OrderKey 
		,[PoNummer]
      ,[Lieferschein]
      ,[Lieferdatum]
      ,[Lieferzeit]
      ,[Kartons]
      ,[Paletten]
      ,[Bemerkung]
      ,[Lieferant]
      ,[Statusnummer]
      ,[Statustext]
  FROM [BI_Data].[dbo].[we]
), 
BOOKING as
(SELECT case 
when prh.[Group7 Reference] = ' ' then prh.[Order No_]
else prh.[Order No_] + prh.[Group7 Reference] 
end as OrderKey
, prh.[Order No_] as PoNummer
, prh.[Group7 Reference] as Lieferschein
, prh.[Pay-to Name]
, cast(prh.[Order Date] as date) as "Order Date"
, cast(prh.[Posting Date] as date) as "Buchungsdatum"
, cast(prh.[Document Date] as date) as "Document Date"
, prl.[Item No_] as EAN
, cast (prl.Quantity as int) as Quantity

      
  FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] as prh
  left join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry] as prl
  on prl.[Document No_]=prh.[No_]
  where prl.[Posting Date] between @from and @to
)

select	
		BOOKING.PoNummer
		, BOOKING.Lieferschein
		, BOOKING.EAN
		, BOOKING.Quantity
		, WE.Lieferdatum
		, CASE 
			WHEN we.bemerkung LIKE ('%icket%') THEN we.bemerkung
			WHEN we.bemerkung like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN we.bemerkung
			WHEN we.bemerkung LIKE('%Kl.rung%') THEN we.bemerkung
			ELSE ' ' END as Bermerkung
		, cast(BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as "Lieferdatum Angepasst"
		, DATEPART( wk, BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
		, BOOKING.Buchungsdatum
		, datediff(dd, cast(BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), BOOKING.Buchungsdatum) + CASE
                                   WHEN datepart(dw, cast(BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 7 THEN 1
                                   ELSE 0
                               END - (datediff(wk, cast(BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), BOOKING.Buchungsdatum) * 2) - CASE
                                                                        WHEN datepart(dw, cast(BI_Staging.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 1 THEN 1
                                                                        ELSE 0
                                                                    END + CASE
                                                                              WHEN datepart(dw, BOOKING.Buchungsdatum) = 1 THEN 1
                                                                              ELSE 0
                                                                          END + 1 as Date_Diff
from BOOKING
join WE 
	on BOOKING.OrderKey = WE.OrderKey
--order by BOOKING.Buchungsdatum asc
order by WE.lieferdatum asc