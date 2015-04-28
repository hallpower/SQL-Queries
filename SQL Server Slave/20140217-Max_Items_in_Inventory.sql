/*
Maximum Items in Inventory per SKU (no duplicates)
*/

WITH all_records as(
SELECT	EAN 
		, MAX(InStorage) AS hist_max
FROM History.dbo.ItemLedgerEntryAggr
WHERE [Location Code] = 'FIEGE'
GROUP BY EAN

UNION

SELECT	EAN 
		, MAX(InStorage) AS hist_max
FROM BI_Data.dbo.ItemLedgerEntryAggr
WHERE [Location Code] = 'FIEGE'
GROUP BY EAN
)

select EAN, MAX(hist_max) from all_records
group by EAN
order by EAN
-- BI_Data.item.ItemLedgerEntryAGGLast180DaysToCurrent