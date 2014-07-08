select * from gb_we_time


select 	we.ponummer, 
	we.lieferschein, 
	(we.lieferdatum || ' ' || we.lieferzeit)::timestamp as "WE Time", 
	we.kartons, 
	we.paletten, 
	we.bemerkung, 
	min(gb.modified) as "Booking Time",
	sum(cast(gb.unit as float)*cast(gb.quantityshipped as float)) as "Pieces"
from gb_we_time as we
left join gb_booking_time as gb
on gb.best_str=we.ponummer and gb.del_slip=we.lieferschein

--where ponummer = 'BEST-1020756'
group by we.ponummer, we.lieferschein, we.lieferdatum, we.lieferzeit, we.kartons, we.paletten, we.bemerkung
order by we.ponummer asc;


select 	gb.best_str, 
	gb.del_slip, 
	min(gb.modified) as "Booking Time", 
	sum(cast(gb.unit as float)*cast(gb.quantityshipped as float)) as "Pieces",
	(we.lieferdatum || ' ' || we.lieferzeit)::timestamp as "WE Time", 
	we.kartons, 
	we.paletten 

from gb_booking_time as gb

left join gb_we_time as we
on gb.best_str=we.ponummer and gb.del_slip=we.lieferschein

where best_str not like ('%UMLG%')

group by gb.best_str, gb.del_slip, we.lieferdatum, we.lieferzeit, we.kartons, we.paletten

order by gb.best_str, gb.del_slip asc;