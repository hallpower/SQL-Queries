with artikel as 
(select	SKU.[Vendor No_] as Kreditor
		, SKU.[Item No_]
		, SKU.[Replenishment System]
		, SKU.Klasse
from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Stockkeeping Unit] SKU with (nolock)
where SKU.[Location Code] = 'USTER'
and SKU.Klasse = 'K'
-- and Sku.[Item No_] = '8003444826696'
)
, bestand AS
(
select 	ILE.[Item No_]
		, cast(sum(ILE.Quantity) as int) as Bestand
from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item Ledger Entry] ILE with (nolock) 
where ILE.[Location Code] = 'USTER'
-- and ILE.[Item No_] = '8003444826696'
group by ILE.[Item No_]
)
, in_purchase as 
(
select	PL.No_ as No_
-- 		, PL.[Document No_]
		, cast(sum(PL.Quantity) as int) as In_Bestellung
from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Purchase Line] PL with (nolock) 
where PL.[Location Code] = 'USTER'
-- and PL.No_ = '8003444826696'
group by PL.No_
-- 		, PL.[Document No_]
)
, in_sales as 
(
select 	SL.No_
-- 		, SL.[Document No_]
		, cast(sum(SL.Quantity) as int) as In_Auftrag
from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Line] SL with (nolock) 
where SL.[Location Code] = 'USTER'
-- and SL.No_ = '7640126541600'
group by SL.No_
-- 		, SL.[Document No_]
)

select 	artikel.[Item No_]
		, artikel.Kreditor
		, artikel.Klasse
		, artikel.[Replenishment System]
		, isnull(bestand.Bestand,0) as Bestand
		, isnull(in_purchase.In_Bestellung,0) as In_Bestellung
		, isnull(in_sales.In_Auftrag,0) as In_Auftrag
		, isnull(bestand.Bestand + in_purchase.In_Bestellung - in_sales.In_Auftrag,0) as Stand

from artikel
full outer join bestand on artikel.[Item No_] = bestand.[Item No_]
full outer join in_purchase on in_purchase.No_ = artikel.[Item No_]
full outer join in_sales on in_sales.No_ = artikel.[Item No_]

-- where artikel.[Item No_] = '8003444826696'

where (bestand.Bestand + in_purchase.In_Bestellung - in_sales.In_Auftrag) < 0

group by artikel.[Item No_]
		, artikel.Kreditor
		, artikel.Klasse
		, artikel.[Replenishment System]
		, bestand.Bestand
		, in_purchase.In_Bestellung
		, in_sales.In_Auftrag
