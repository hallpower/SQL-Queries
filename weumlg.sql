with we as 
	(
	select  no_
		, "Document Line No_"
		, "Posting Date"
		, quantity as "WE Quantity"
		, sum(quantity) over (partition by no_ order by no_, "Document Line No_" asc) as "WE Cumulative"
	from UMLG_WE
	-- WE must be in July to count. If in August, then August Malus. 
	where "Posting Date" between '2013-07-01' and '2013-07-31'
	order by no_, "Document Line No_" asc
	),
	wa as
	(
	select  no_
		, "Document Line No_"
		, "Posting Date"
		, -quantity as "WA Quantity"
		, sum(-quantity) over (partition by no_ order by no_, "Document Line No_" asc) as "WA Cumulative"
	from UMLG_WA
	order by no_, "Document Line No_" asc
	)

select sum(case when we."Posting Date" - wa."Posting Date" > 4 then we."WE Quantity" else 0 end)
from we
full outer join wa
on we.no_=wa.no_


