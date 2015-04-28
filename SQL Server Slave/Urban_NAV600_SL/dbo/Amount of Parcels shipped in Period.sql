/*
Lists parcels shipped in a timeframe. 
*/

-- Doesn't work with Navicat! Need to include variables in query. 
-- DECLARE @fromdate DATETIME = '2013-02-01 00:00:00'
-- DECLARE @todate DATETIME = '2013-02-14 23:59:59';


WITH p AS (
	SELECT
		OrderID COLLATE Latin1_General_CS_AI AS OrderID
		,TrackingID
		,CAST (KnownToPostalServiceTimestamp AS DATE) AS OrderDate
	FROM
		BI_Staging.dbo.PostalServiceTracking2 WITH (nolock)
	WHERE
		KnownToPostalServiceTimestamp BETWEEN '2013-02-01 00:00:00' AND '2013-02-14 23:59:59'
	--AND [Reason Code] = 'WINDELN_DE'
),
 s AS (
	SELECT
		No_,
		[Ship-to Country_Region Code]
	FROM
		Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] WITH (nolock)
) SELECT
	p.OrderID,
	p.TrackingID,
	p.OrderDate,
	s.[Ship-to Country_Region Code]
FROM
	p
JOIN s ON p.OrderID = s.No_
GROUP BY
	p.OrderID,
	p.TrackingID,
	p.OrderDate,
	s.[Ship-to Country_Region Code]