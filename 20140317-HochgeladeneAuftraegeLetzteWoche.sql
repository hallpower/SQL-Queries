/******
Script to determine Orders and Files uploaded in
predefined timeframe.   
******/


DECLARE @fromdate DATETIME = dateadd(hh, -1,dateadd(wk, datediff(wk, 0, getdate()) - 1, 0)) --adjust server time to utc
DECLARE @todate DATETIME = dateadd(hh, -1,dateadd(wk, datediff(wk, 0, getdate()) - 1, 0) + 7); -- adjust server time to utc


SELECT	cast(dateadd(hh, 1,ffp.[Timestamp Upload_Download]) as date) as UploadDate
		, count(sh.[No_]) as Uploaded -- adjust server time to utc
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh
join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp
on ffp.[File No_] = sh.[File No_]
where ffp.[Timestamp Upload_Download] between @fromdate and @todate
and sh.[File No_] like 'A6%' 
group by cast(dateadd(hh, 1,ffp.[Timestamp Upload_Download]) as date)
order by cast(dateadd(hh, 1,ffp.[Timestamp Upload_Download]) as date)