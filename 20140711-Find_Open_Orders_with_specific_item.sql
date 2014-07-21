/*
Query to determine which Sales Orders only have one specific 
item outstanding.

Logic:
1. Find all Sales Orders that contain item with existing 
remaining Quantity.
2. Of those orders, remove all that have more than 1 item 
outstanding it total. 

Possible improvements: use case statement to count all 
SKUs that have at least one remaining (this would allow 
also sorting through Sales Orders that have more than 
Quantity = 1 of an item.)
*/

select	sl.[Document No_]
		, sh.[Document Type]
		, sum(sl.[Outstanding Quantity]) as Total_Outstanding_Quantity
from Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Line] sl
join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Header] sh
on sl.[Document No_] = sh.No_
where sl.[Document No_]
in 
(select distinct sl.[Document No_]
from Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Line] sl
where sl.No_ in ('4260288624862', '4260288624879')
and sl.[Outstanding Quantity] > 0
)
group by sl.[Document No_]
		, sh.[Document Type]
having SUM(sl.[Outstanding Quantity]) = 1