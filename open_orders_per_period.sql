/*Aufträge übertragen und offen in der aktuellen Periode*/
SELECT 
  COUNT (No_) AS OpenOrdersCurrentPeriod
FROM  [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales HEADER] WITH (NOLOCK)
WHERE
  [DHL Reporting DATE] /*Gestern Cutoff Zeit*/
  BETWEEN CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME) /*Heute Cutoff Zeit*/
AND CAST (Getdate() AS datetime) + CAST ('15:00:00' AS TIME) - CAST (Getdate() AS TIME)
AND [DOCUMENT TYPE] = 11
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 


/*Aufträge übertragen und erledigt in der aktuellen Periode*/
SELECT 
  COUNT (No_) AS SentOrdersCurrentPeriod
FROM
  [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales Shipment HEADER] WITH (NOLOCK)
WHERE
  [DHL Reporting DATE] /*Gestern Cutoff Zeit*/
  BETWEEN CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME) /*Heute Cutoff Zeit*/
AND CAST (Getdate() AS datetime) + CAST ('15:00:00' AS TIME) - CAST (Getdate() AS TIME)
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 


/*Aufträge übertragen und offen in der letzten abgeschlossenen Periode*/
SELECT
  COUNT (No_) AS OpenOrdersLastPeriod
FROM
  [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales HEADER] WITH (NOLOCK)
WHERE
  [DHL Reporting DATE] /*Vorgestern Cutoff Zeit*/
  BETWEEN CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME) /*Gestern Cutoff Zeit*/
AND CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME)
AND [DOCUMENT TYPE] = 11
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 


/*Aufträge übertragen und erledigt in der letzten abgeschlossenen Periode*/
SELECT
  COUNT (No_) AS SentOrdersLastPeriod
FROM
  [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales Shipment HEADER] WITH (NOLOCK)
WHERE
  [DHL Reporting DATE] /*Vorgestern Cutoff Zeit*/
  BETWEEN CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME) /*Gestern Cutoff Zeit*/
AND CAST ((Getdate() - 1) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 1) AS TIME)
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH') 


/*Aufträge älter als 2 Tage und offen */
SELECT
  COUNT (No_) AS OpenOrdersOlder2Days
FROM
  [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Sales HEADER] WITH (NOLOCK)
WHERE
  [DHL Reporting DATE] < CAST ((Getdate() - 2) AS datetime) + CAST ('15:00:00' AS TIME) - CAST ((Getdate() - 2) AS TIME)
AND [Reason Code] IN ('WINDELN_DE', 'WINDELN_CH')

AND [DOCUMENT TYPE] = 11