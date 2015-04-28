/*
Lists parcels shipped in a timeframe. 
*/

-- Doesn't work with Navicat! Need to include variables in query. 
-- DECLARE @fromdate DATETIME = '2013-02-01 00:00:00'
-- DECLARE @todate DATETIME = '2013-02-14 23:59:59';


WITH p AS 
(
	SELECT	OrderID COLLATE Latin1_General_CS_AI AS OrderID
			, TrackingID
			, CAST (KnownToPostalServiceTimestamp AS DATE) AS OrderDate
	FROM BI_Data.dbo.PostalServiceTracking WITH (nolock)
	WHERE KnownToPostalServiceTimestamp BETWEEN '2014-02-01' AND '2014-06-30'
		--AND [Reason Code] = 'WINDELN_DE'
),
s AS 
(
	SELECT 	No_
			, [Ship-to Country_Region Code]
	FROM Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] WITH (nolock)
), 
resultset as 
(
	SELECT	s.[Ship-to Country_Region Code] as Land
			, datepart(mm, p.OrderDate) as Monat
			, count(distinct p.TrackingID) as Anzahl_Parcels
	FROM p
	JOIN s ON p.OrderID = s.No_
	where s.[Ship-to Country_Region Code] is not null
	GROUP BY 	datepart(mm, p.OrderDate)
				, s.[Ship-to Country_Region Code]
) 

select	Land
		, isnull([2],0) as [2]
		, isnull([3],0) as [3]
		, isnull([4],0) as [4]
		, isnull([5], 0) as [5]
		, isnull([6],0) as [6]
from 
	(
	select Land, Monat, Anzahl_Parcels
	from resultset
	) rs
PIVOT
	(
	sum(Anzahl_Parcels) for Monat in ([2], [3], [4], [5], [6])
	) as pvt
order by pvt.Land

