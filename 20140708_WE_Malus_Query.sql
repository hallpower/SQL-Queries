-- This query takes holidays in between two dates into account. 

Declare @fromDate date = '2014-06-01'
Declare @toDate date = '2014-06-30'


select  prh.[Order No_] as PO
    , prh.[Group7 Reference] as Lieferschein
    , prh.No_ as EKL
    , we.Lieferdatum as WE_Datum
    , cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as WE_Datum_Adj
    , DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
    , we.Lieferzeit as WE_Zeit
    , cast (prh.[Posting Date] as date) as Buchungsdatum
    , ile.[Item No_] as SKU
    , ile.Quantity as Anzahl
    , datediff(dd, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), prh.[Posting Date]) + CASE
                                   WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 7 THEN 1
                                   ELSE 0
                               END - (datediff(wk, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), prh.[Posting Date]) * 2) - CASE
                                                                        WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 1 THEN 1
                                                                        ELSE 0
                                                                    END + CASE
                                                                              WHEN datepart(dw, prh.[Posting Date]) = 1 THEN 1
                                                                              ELSE 0
                                                                          END + 1 -
                                                                          (select count(*) from BI_Data.dbo.Holidays_Bradenburg 
                                      where HolidayDate 
                                        between cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) 
                                        and prh.[Posting Date])
                                                                          as Date_Diff
    , CASE 
            WHEN we.bemerkung LIKE ('%icket%') THEN we.bemerkung
            WHEN prh.[Your Reference] LIKE ('%icket%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
            WHEN we.bemerkung like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN we.bemerkung
            WHEN prh.[Your Reference] like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
            WHEN we.bemerkung LIKE('%Kl.rung%') THEN we.bemerkung
            WHEN prh.[Your Reference] LIKE('%Kl.rung%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
            ELSE ' ' END as Ticket
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] prh with (nolock) 

left join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item Ledger Entry] ile with (nolock) 
  on ile.[Document No_] = prh.No_

left join [BI_Data].[dbo].[we] we with (nolock)
  on we.PoNummer = prh.[Order No_] collate Latin1_General_100_CS_AS
    and we.Lieferschein = prh.[Group7 Reference] collate Latin1_General_100_CS_AS

where prh.[Posting Date] between @fromDate and @toDate
and prh.[Location Code] = 'BER_FIEGE'



-- depricated 19.06.2014
-- Declare @fromDate date = '2014-03-01'
-- Declare @toDate date = '2014-03-31';


-- select	prh.[Order No_] as PO
-- 		, prh.[Group7 Reference] as Lieferschein
-- 		, prh.No_ as EKL
-- 		, we.Lieferdatum as WE_Datum
-- 		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as WE_Datum_Adj
-- 		, DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
-- 		, we.Lieferzeit as WE_Zeit
-- 		, cast (prh.[Posting Date] as date) as Buchungsdatum
-- 		, ile.[Item No_] as SKU
-- 		, ile.Quantity as Anzahl
-- 		, datediff(dd, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), prh.[Posting Date]) + CASE
--                                    WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 7 THEN 1
--                                    ELSE 0
--                                END - (datediff(wk, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE), prh.[Posting Date]) * 2) - CASE
--                                                                         WHEN datepart(dw, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)) = 1 THEN 1
--                                                                         ELSE 0
--                                                                     END + CASE
--                                                                               WHEN datepart(dw, prh.[Posting Date]) = 1 THEN 1
--                                                                               ELSE 0
--                                                                           END + 1 as Date_Diff
-- 		--, prh.[Your Reference] + ' ' + we.Bemerkung collate Latin1_General_100_CS_AS as Ticket
-- 		, CASE 
--             WHEN we.bemerkung LIKE ('%icket%') THEN we.bemerkung
--             WHEN prh.[Your Reference] LIKE ('%icket%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
--             WHEN we.bemerkung like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN we.bemerkung
--             WHEN prh.[Your Reference] like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
--             WHEN we.bemerkung LIKE('%Kl.rung%') THEN we.bemerkung
--             WHEN prh.[Your Reference] LIKE('%Kl.rung%') THEN prh.[Your Reference] collate Latin1_General_100_CS_AS
--             ELSE ' ' END as Ticket
-- FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] prh with (nolock) 

-- left join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item Ledger Entry] ile with (nolock) 
-- 	on ile.[Document No_] = prh.No_

-- left join [BI_Data].[dbo].[we] we with (nolock)
-- 	on we.PoNummer = prh.[Order No_] collate Latin1_General_100_CS_AS
-- 		and we.Lieferschein = prh.[Group7 Reference] collate Latin1_General_100_CS_AS

-- where prh.[Posting Date] between @fromDate and @toDate
-- and prh.[Location Code] = 'BER_FIEGE'
-- 18,734 Wareneingaenge insgesamt
-- 19,145 Wareneingaenge durch Duplikate

--sla as 
--(


--select	DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)) as KW
--		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE) as WE_Datum_Adj
--		--, sum(ile.Quantity) as Anzahl
--		, sum(ile.Quantity) over(partition by datepart(dd, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)))
--		/ sum(ile.Quantity) over(partition by DATEPART(wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum))) as pow
--		, case 
--			when sum(ile.Quantity) over(partition by datepart(dd, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum)))
--		/ sum(ile.Quantity) over(partition by DATEPART(wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum))) > 0.25 then 3
--		else 2 end as SLA
--		--, sum(case 
--  --      when [entry_date] >= '2012-12-01' and [entry_date] <= '2012-12-31' 
--  --      then ile.Quantity 
--  --      else 0 
--  --  end) AS Percent
--FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] prh with (nolock) 

--left join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item Ledger Entry] ile with (nolock) 
--	on ile.[Document No_] = prh.No_

--left join [BI_Data].[dbo].[we] we with (nolock)
--	on we.PoNummer = prh.[Order No_] collate Latin1_General_100_CS_AS
--		and we.Lieferschein = prh.[Group7 Reference] collate Latin1_General_100_CS_AS

--where prh.[Posting Date] between dateadd(dd,-3,@fromDate) and @toDate
--and prh.[Location Code] = 'BER_FIEGE'
--group by DATEPART( wk, BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum))
--		, cast(BI_Data.dbo.AdjustedWeDay(WE.Lieferdatum) as DATE)
--		, WE.Lieferdatum
--		, ile.Quantity
---- 18,734 Wareneingaenge insgesamt
---- 19,045 Wareneingaenge durch Duplikate
--)