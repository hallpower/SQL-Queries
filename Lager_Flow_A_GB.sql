/**** Flow for Aufträge between Apfelstädt and Großbeeren *****/

-- delcare variables
declare @todate date = '2013-06-01'

-- 
select 	a.Lager
	, count(a.[Order Date]) as "Sales Header"
	, count(ssh.[Order Date]) as "Shipment Header" 
from 	(
	select 	esh.No_ as No_
		, LEFT(esh.[File No_],2) as Lager
		, sh.[Order Date] as "Order Date"
	from [urban_NAV600].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] as esh
	left outer join [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Header] as sh
		on sh.No_ = esh.No_
	where esh.[Order Date]>= @todate
		and esh.[File No_] like ('%A6%') or esh.[File No_] like ('%A3%')
	) a
left outer join [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Shipment Header] as ssh
	on a.No_=ssh.[Order No_]
group by a.Lager;