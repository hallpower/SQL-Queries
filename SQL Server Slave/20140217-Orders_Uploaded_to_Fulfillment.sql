/****** 
Script to determine Orders and Files uploaded in
predefined timeframe.    
******/

DECLARE @fromdate DATETIME = dateadd(hh, -1,'2014-02-14 00:00') --adjust server time to utc
DECLARE @todate DATETIME = dateadd(hh, -1,getdate()) -- adjust server time to utc


SELECT	sh.[No_]
		, sh.[File No_]
		, BI_DATA.dbo.ToUTCDate(ffp.[Timestamp Upload_Download]) AS Zeitstempel -- adjust server time to utc
		, sh.[Shipping Agent Service Code] as Transportcode

FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh

JOIN [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp
	ON ffp.[File No_] = sh.[File No_]

WHERE ffp.[Timestamp Upload_Download] BETWEEN @fromdate AND @todate
AND sh.[File No_] LIKE 'A6%'