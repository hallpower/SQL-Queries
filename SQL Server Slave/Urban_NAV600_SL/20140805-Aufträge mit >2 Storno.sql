/*
Aufträge mit mehr als 2 Storno und in Sales Header
*/

select ffsh.No_ as Auftragsnummer
		, CAST (ffsh.[Order Date] AS DATE) AS Bestelldatum
		, case 
			when ffsh.Type = 2 then 'Storno'
			when ffsh.Type = 4 then 'Storno Rückmeldung'
		end as Status
		, ffsh.[Entry No_] / 2 as 'Anzahl Stornos'
from urban_nav600_sl.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] ffsh
join urban_nav600_sl.dbo.[Urban-Brand GmbH$Sales Header] sh 
	on ffsh.No_ = sh.No_
inner join 
(
select No_, max([Entry No_]) maxENo_
from urban_nav600_sl.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] 
group by No_
) mE
	on mE.No_ = ffsh.No_ and me.maxENo_ = ffsh.[Entry No_]
where ffsh.[Location Code] = 'BER_FIEGE'
	and ffsh.Type in (2,4)
	and ffsh.[Entry No_] >= 4
group by ffsh.No_
		, CAST (ffsh.[Order Date] AS DATE)
		, case 
			when ffsh.Type = 2 then 'Storno'
			when ffsh.Type = 4 then 'Storno Rückmeldung' end
		, ffsh.[Entry No_] / 2
ORDER BY ffsh.No_ asc