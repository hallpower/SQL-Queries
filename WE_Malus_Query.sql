  SELECT	prh.[Order No_]
		, prh.[Group7 Reference]
		, prh.[Pay-to Name]
		, cast(prh.[Order Date] as date) as "Order Date"
		, cast(prh.[Posting Date] as date) as "Posting Date"
		, cast(prh.[Document Date] as date) as "Document Date"
		, prl.[Item No_]
		, prl.Quantity

      
  FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] as prh
  left join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry] as prl
  on prl.[Document No_]=prh.[No_]
  where prl.[Posting Date] between '2013-08-1' and '2013-08-31'
  and LEFT(prh.[Order No_],4) not like ('UMLG')
  and prh.[Group7 Reference] not like ('UMZUG')
  group by prh.[Order No_]
		, prh.[Group7 Reference]
		, prh.[Pay-to Name]
		, cast(prh.[Order Date] as date)
		, cast(prh.[Posting Date] as date)
		, cast(prh.[Document Date] as date)
		, prl.[Item No_]
		, prl.Quantity
	order by cast(prh.[Posting Date] as date) asc