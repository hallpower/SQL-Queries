/*
Order without response.
*/

DECLARE @fromdate DATETIME = '2013-01-01 9:00'  
DECLARE @todate DATETIME = getdate()   

SELECT 	sh.[No_] as No_  
		, sh.[File No_]
		, ffp.[Timestamp Upload_Download] as uploaded 
		, ffp.[Message]   
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh

join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp 
	on ffp.[File No_] = sh.[File No_]

where ffp.[Timestamp Upload_Download] between @fromdate and @todate 
and sh.[File No_] like 'A6%' and sh.[No_] in
			
(
SELECT No_ AS OpenOrdersOlder2Days 
FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales HEADER] WITH (NOLOCK)
WHERE [DHL Reporting DATE] between @fromdate and @todate 
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 
AND [DOCUMENT TYPE] = 11
)

order by uploaded 