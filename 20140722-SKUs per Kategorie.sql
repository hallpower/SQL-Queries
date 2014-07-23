select	left(il.[Attribute 2],1)+'00' as Kategorie
		, dv.Name as Kategorie_Name
		, COUNT(distinct ile.EAN) as SKUs
from BI_Data.dbo.ItemLedgerEntryAggr ile

join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item] il
	on ile.EAN = il.No_ collate Latin1_General_CI_AS
join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Dimension Value] dv
	on left(il.[Attribute 2],1)+'00' = dv.Code

where [Location Code] = 'FIEGE'
	and DateValue = '2014-07-09'
	and InStock > 0
	and dv.[Dimension Code] = 'KATEGORIE'

group by left(il.[Attribute 2],1)
		, dv.Name
order by left(il.[Attribute 2],1)