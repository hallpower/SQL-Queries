/*
Query to determine which items that are stored in BER_FIEGE are sold on the WINDELN_CH webshop.
Item must have had inventory in BER_FIEGE before and not be an 'E-Artikel' with '0' Inventory.
*/

WITH positive_data AS
 */
(
    SELECT DISTINCT
        ffsl.No_                             AS No_
      , i.Description                        AS Description
      , i.[Description 2]                    AS [Description 2]
      , i.[Attribute 2]                      AS Category_Code
      , sku.Klasse                           AS Klasse
      , icpg.Preferred                       AS Preferred
      , icpg.[Country_Region Code]           AS [Country_Region Code]
      , dv.Name                              AS Category_Name
      , cast(max(ffsh.[Order Date]) AS DATE) AS Letzte_Bestellung
      , cast(sum(ffsl.Quantity) AS INT)      AS Gesamt_Bestellt
      , ile.InStock                          AS InStock
      , i.[Tariff No_]                       AS Tariff_No_DE
      , icpg.[Tariff No_]                    AS Tariff_No_CH
      , i.[Country_Region of Origin Code]    AS Country_Origin
    FROM Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesLine] ffsl WITH ( NOLOCK )
      JOIN Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] ffsh WITH ( NOLOCK )
        ON ffsh.No_ = ffsl.[Document No_] AND ffsh.[Entry No_] = ffsl.[Document Entry No_]
      JOIN Urban_Nav600_SL.dbo.[Urban-Brand GmbH$Item] i WITH ( NOLOCK )
        ON ffsl.No_ = i.No_
      FULL OUTER JOIN Urban_Nav600_SL.[dbo].[Urban-Brand GmbH$Item Country Posting Group] icpg WITH ( NOLOCK )
        ON icpg.No_ = ffsl.No_
      JOIN Urban_Nav600_SL.dbo.[Urban-Brand GmbH$Dimension Value] dv WITH ( NOLOCK )
        ON dv.Code = i.[Attribute 2]
      JOIN Urban_Nav600_SL.[dbo].[Urban-Brand GmbH$Stockkeeping Unit] sku WITH ( NOLOCK )
        ON sku.[Item No_] = ffsl.No_
      JOIN
      (
        SELECT
          EAN
          , max(InStock)   AS InStock
          , max(DateValue) AS DateValue
        FROM BI_Data.[dbo].[ItemLedgerEntryAggr] WITH ( NOLOCK )
        WHERE [Location Code] = 'FIEGE'
        GROUP BY EAN
        HAVING max(InStock) > 0
      ) AS ile -- Removing all items that never had stock in Fiege
        ON ffsl.No_ = ile.EAN
      COLLATE Latin1_General_CI_AS
    WHERE ffsh.[Order Date] >= '2014-08-01'
          AND ffsl.Type = 2
          AND ffsh.[Entry No_] = 1
          -- 		and ffsh.[Location Code] = 'BER_FIEGE'
          AND dv.[Dimension Code] = 'KATEGORIE'
          AND ffsh.[Reason Code] = 'WINDELN_CH'
          AND (icpg.[Tariff No_] = ''
               OR i.[Country_Region of Origin Code] = '')
          AND icpg.[Country_Region Code] IN ('LI', 'CH')
          AND sku.[Location Code] = 'BER_FIEGE'
    GROUP BY ffsl.No_
      , i.Description
      , i.[Description 2]
      , i.[Attribute 2]
      , sku.Klasse
      , icpg.Preferred
      , icpg.[Country_Region Code]
      , dv.Name
      , ile.InStock
      , i.[Tariff No_]
      , icpg.[Tariff No_]
      , i.[Country_Region of Origin Code]
), negative_data AS -- get ride of all E-Artikel with 0 Inventory
(
    SELECT ile.EAN AS No_
    FROM BI_Data.[dbo].[ItemLedgerEntryAggr] ile WITH ( NOLOCK )
      JOIN Urban_Nav600_SL.[dbo].[Urban-Brand GmbH$Stockkeeping Unit] sku WITH ( NOLOCK )
        ON sku.[Item No_] = ile.EAN
      COLLATE Latin1_General_100_CS_AS
    WHERE ile.[Location Code] = 'FIEGE'
          AND ile.DateValue = cast(getdate() AS DATE)
          AND ile.InStock = 0
          AND sku.Klasse = 'E'
    GROUP BY ile.EAN
)

SELECT pd.*
FROM positive_data pd
  LEFT OUTER JOIN negative_data nd
    ON pd.No_ = nd.No_
  COLLATE Latin1_General_100_CS_AS
WHERE nd.No_ IS NULL
ORDER BY pd.Gesamt_Bestellt DESC


