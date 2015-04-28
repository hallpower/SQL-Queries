/*Aufträge übertragen und offen in der aktuellen Periode*/
SELECT
	SUM (
		CASE
		WHEN sh.[DHL Reporting Date] BETWEEN CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME) /*Heute Cutoff Zeit*/
		AND CAST (Getdate() AS datetime) + CAST ('15:00:00' AS TIME) - CAST (Getdate() AS TIME)
		AND sh.[DOCUMENT TYPE] = 11
		AND sh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 
		THEN 1 ELSE 0 END
		) AS OpenCurrentPeriod,
	SUM (
		CASE
		WHEN ssh.[DHL Reporting DATE] BETWEEN CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME) /*Heute Cutoff Zeit*/
		AND CAST (Getdate() AS datetime) + CAST ('15:00:00' AS TIME) - CAST (Getdate() AS TIME)
		AND ssh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') THEN 1 ELSE 0 END
		) AS SentCurrentPeriod,
	SUM (
		CASE
		WHEN sh.[DHL Reporting DATE] BETWEEN CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME) /*Gestern Cutoff Zeit*/
		AND CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME)
		AND sh.[DOCUMENT TYPE] = 11
		AND sh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') THEN 1 ELSE 0 END
		) AS OpenLastPeriod,
	SUM (
		CASE
		WHEN ssh.[DHL Reporting DATE] BETWEEN CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME) /*Gestern Cutoff Zeit*/
		AND CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME)
		AND ssh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') THEN 1 ELSE 0 END
		) AS SentLastPeriod,
	SUM (
		CASE
		WHEN sh.[DHL Reporting DATE] < CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME) /* Älter als Gestern Cutoff Zeit */
		AND sh.[Reason Code] IN ('WINDELN_DE', 'WINDELN_CH')
		AND sh.[Document Type] = 11 THEN 1 ELSE 0 END
		) AS OpenOlder2Days
FROM
	[urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales HEADER] sh WITH (NOLOCK)
FULL OUTER JOIN [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales Shipment Header] ssh WITH (NOLOCK) 
	ON ssh.No_ = sh.No_