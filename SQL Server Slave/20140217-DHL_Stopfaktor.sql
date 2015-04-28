/*
Calculate the DHL-Stopfaktor in a given timeframe. 
*/


with stops as 
(
select	cast (t.DeliveryTimestamp as date) as Delivery_Date
		, s.[Ship-to City]
		, s.[Ship-to Code]
		, s.[Ship-to Address]
		, count(t.TrackingID) as Packages_per_Stop

from Urban_NAV600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] s
left Join BI_Staging.dbo.PostalServiceTracking2 t
	on t.OrderID = s.No_ collate Latin1_General_100_CS_AS
where [Order Date] between '2014-01-01' and getdate()
group by	cast (t.DeliveryTimestamp as date)
			, [Ship-to Address]
			, [Ship-to City]
			, [Ship-to Code]
--order by Packages_per_Stop desc
)

select	--Order_Date
		--, 
		AVG(cast (Packages_per_Stop as double precision)) as Stop_Faktor
	from stops
	--group by Order_Date