-- select best_str, unit, quantityshipped, cast(unit as float)*cast(quantityshipped as float) from gb_booking_time 
-- 
-- select * from gb_we_time

select 	bt.best_str,
	bt.del_slip, 
	(we.lieferdatum || ' ' || we.lieferzeit)::timestamp as Liefertimestamp,
	we.kartons, 
	we.paletten,
	(cast(bt.unit as float) * cast(bt.quantityshipped as float)) as quantity, 
	bt.modified as "Booking Timestamp",
	((extract (epoch from (bt.modified::timestamp - (we.lieferdatum || ' ' || we.lieferzeit)::timestamp)))/3600)::float as "Service Level" --hours difference
from gb_we_time as we
left join gb_booking_time as bt
	on we.lieferschein=bt.del_slip
	and we.ponummer=bt.best_str
order by Liefertimestamp asc;

-- update gb_we_time
-- set lieferzeit = '00:00'
-- where lieferzeit = 'null';