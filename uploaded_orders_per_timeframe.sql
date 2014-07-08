/****** 
Script to determine Orders and Files uploaded in
predefined timeframe.    
******/

DECLARE @fromdate DATETIME = dateadd(hh, -1,'2014-02-14 00:00') --adjust server time to utc
DECLARE @todate DATETIME = dateadd(hh, -1,getdate()) -- adjust server time to utc


SELECT	sh.[No_]
		, sh.[File No_]
		, dateadd(hh, 1,ffp.[Timestamp Upload_Download]) as Zeitstempel -- adjust server time to utc
		, ffp.[Message]
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh
	join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp
		on ffp.[File No_] = sh.[File No_]
where ffp.[Timestamp Upload_Download] between @fromdate and @todate
and sh.[File No_] like 'A6%'