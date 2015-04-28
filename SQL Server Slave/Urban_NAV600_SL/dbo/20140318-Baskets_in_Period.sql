/*
Lists order baskets in timeframe for volume analysis in DHL Shipping. 
*/


select 	sh.No_
		, sh.[Order Date]
		, sl.[Line No_]
		, sl.No_
		, sl.Description
		, sl.Quantity
	FROM
		Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] sh WITH (nolock)
left join
		Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesLine] sl WITH (nolock)
	on sh.No_ = sl.[Document No_]
where sh.[Order Date] between '2014-01-31 15:00' and '2014-02-28 15:00'