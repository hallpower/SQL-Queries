/*
WA-Malus Query
*/

-- Doesn't work with Navicat. Must define variables in-line. 
-- DECLARE @fromdate DATETIME = '2013-12-31 00:00:00'
-- DECLARE @todate DATETIME = '2014-01-31 23:59:59';

WITH
orderdate AS
(



SELECT     sh.[No_] AS OrderID
          , sh.[File No_] AS FileID
          , dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS SendTimestamp
          , CASE
               WHEN CAST(BI_Staging.dbo.NextWorkingDayWA(dateadd(hh, 1, ffp.[Timestamp Upload_Download])) AS DATE) <> CAST (dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS DATE) THEN 6
               WHEN CAST(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS TIME) <= '06:00' THEN 6
               WHEN CAST(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS TIME) <= '10:00' THEN 10
               WHEN CAST(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS TIME) <= '14:00' THEN 14
               WHEN CAST(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS TIME) <= '15:00' THEN 15
               ELSE 6 END AS TimeCluster -- 8AM + 24hrs
          , CASE
               WHEN CAST(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) AS TIME) > '15:00' THEN CAST(BI_Staging.dbo.NextWorkingDayWA(dateadd(DAY, 1, dateadd(hh, 1, ffp.[Timestamp Upload_Download]))) AS DATE)
               ELSE CAST(BI_Staging.dbo.NextWorkingDayWA(dateadd(hh, 1, ffp.[Timestamp Upload_Download])) AS DATE) END AS DateCluster2
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh WITH (nolock)
JOIN [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp WITH (nolock)
ON ffp.[File No_] = sh.[File No_]
WHERE dateadd(hh, 1, ffp.[Timestamp Upload_Download]) BETWEEN '2013-12-31 00:00:00' AND '2014-01-31 23:59:59'
AND sh.[Setup Code] = 'BER_FIEGE' --sh.[File No_] like 'A3%'
AND sh.[Sell-to Customer No_] NOT IN ('D1164626','D1173541')
AND sh.Type = 0
),
fulfillmentdate AS
(
SELECT     OrderID COLLATE Latin1_General_100_CS_AS AS OrderID
          , MAX(KnownToPostalServiceTimestamp) AS KnownToPostalService
FROM [BI_Staging].[dbo].[PostalServiceTracking2] WITH (nolock)
WHERE KnownToPostalServiceTimestamp > '2013-12-31 00:00:00' -- @fromdate
GROUP BY OrderID
)

SELECT     orderdate.OrderID
          , orderdate.FileID
          , orderdate.SendTimestamp
          , orderdate.DateCluster2 AS UploadDateCluster
          , orderdate.TimeCluster
          , fulfillmentdate.KnownToPostalService AS Fulfilled
          , BI_Staging.dbo.SkipHolidays_bradenburg(orderdate.DateCluster2, fulfillmentdate.KnownToPostalService) AS ServiceLevel
          , CASE
               WHEN BI_Staging.dbo.SkipHolidays_bradenburg(orderdate.DateCluster2, fulfillmentdate.KnownToPostalService) > 0 THEN 1
               ELSE 0
          END AS Malus
FROM Orderdate


LEFT OUTER JOIN fulfillmentdate ON fulfillmentdate.OrderID = orderdate.OrderID 