select	SKU.[Vendor No_] as Kreditor
		, ILE.[Item No_] as EAN
		, cast(sum(ILE.Quantity) as int) as Bestand
		, cast(sum(PL.Quantity) as int) as In_Bestellung
		, cast(sum(SL.Quantity) as int) as In_Auftrag
		, cast(sum(ILE.Quantity) + sum(PL.Quantity) - sum(SL.Quantity) as int) as Stand
		, SKU.[Replenishment System]
		, SKU.Klasse
from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item Ledger Entry] ILE with (nolock) 
full outer join urban_NAV600_SL.dbo.[Urban-Brand GmbH$Stockkeeping Unit] SKU with (nolock) 
	on SKU.[Item No_] = ILE.[Item No_]
full outer join urban_NAV600_SL.dbo.[Urban-Brand GmbH$Purchase Line] PL with (nolock) 
	on PL.No_ = ILE.[Item No_]
full outer join urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Line] SL with (nolock) 
	on SL.No_ = ILE.[Item No_]
where ILE.[Location Code] = 'USTER'
	and SKU.[Location Code] = 'USTER'
	and PL.[Location Code] = 'USTER'
	and SL.[Location Code] = 'USTER'
	and SKU.Klasse = 'K'
group by SKU.[Vendor No_]
		, ILE.[Item No_]
		, SKU.[Replenishment System]
		, SKU.Klasse
order by SKU.[Vendor No_]
		, ILE.[Item No_]