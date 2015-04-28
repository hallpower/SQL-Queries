/*
Order without response.
*/

DECLARE @fromdate DATETIME = '2013-01-01 9:00'  
DECLARE @todate DATETIME = getdate()   

SELECT 	sh.[No_] as No_  
		, sh.[File No_]
		, ffp.[Timestamp Upload_Download] as uploaded 
		, ffp.[Message]   
FROM [Urban_NAV600].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh

join [Urban_NAV600].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp 
	on ffp.[File No_] = sh.[File No_]

where ffp.[Timestamp Upload_Download] between @fromdate and @todate 
and sh.[File No_] like 'A6%' and sh.[No_] in
			
(
SELECT No_ AS OpenOrdersOlder2Days 
FROM [Urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Header] as sh WITH (NOLOCK) 
WHERE sh.[DHL Reporting Date] between @fromdate and @todate 
AND sh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 
AND sh.[Document Type] = 11
)

order by uploaded 