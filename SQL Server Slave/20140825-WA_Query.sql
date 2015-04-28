with 
orderdata as 
(
SELECT	sh.[No_] AS OrderID
		, ffp.[Timestamp Upload_Download] as UTC_Timestamp
		, BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) as BER_Timestamp
          , CASE
               WHEN CAST(BI_Data.dbo.NextWorkingDayWA(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download])) AS DATE) <> CAST (BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS DATE) THEN 6
               WHEN CAST(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS TIME) <= '06:00' THEN 6
               WHEN CAST(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS TIME) <= '10:00' THEN 10
               WHEN CAST(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS TIME) <= '14:00' THEN 14
               WHEN CAST(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS TIME) <= '15:00' THEN 15
               ELSE 6 END AS TimeCluster -- 8AM + 24hrs
          , CASE
               WHEN CAST(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS TIME) > '15:00' THEN CAST(BI_Data.dbo.NextWorkingDayWA(dateadd(DAY, 1, BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]))) AS DATE)
               ELSE CAST(BI_Data.dbo.NextWorkingDayWA(BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download])) AS DATE) END AS DateCluster
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh WITH (nolock)
JOIN [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp WITH (nolock)
ON ffp.[File No_] = sh.[File No_]
WHERE BI_Data.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) BETWEEN '2014-11-30 15:00:00' AND '2014-12-31 15:00'
and sh.[entry no_] = 1
-- and left(sh.[File No_],2) = 'A6'
and sh.Type = 0
),
fulfillmentdata as
(
select 	sh.No_ as OrderID
		, sh.[Posting Date] as Shipping_Date
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh WITH (nolock)
where sh.[Order Date] >= '2014-10-30'
and sh.Type = 1
)

select	o.OrderID
		, o.UTC_Timestamp
		, o.BER_Timestamp
		, o.TimeCluster
		, o.DateCluster
		, datename(dw, o.DateCluster) as Weekday
		, cast(f.Shipping_Date as date) as Shipping_Date
		, BI_Data.dbo.SkipHolidays_bradenburg(o.DateCluster, f.Shipping_Date) AS ServiceLevel
          , CASE
               WHEN BI_Data.dbo.SkipHolidays_bradenburg(o.DateCluster, f.Shipping_Date) > 0 THEN 1
               ELSE 0
          END AS Malus
from orderdata o
join fulfillmentdata f
	on o.OrderID = f.OrderID
			