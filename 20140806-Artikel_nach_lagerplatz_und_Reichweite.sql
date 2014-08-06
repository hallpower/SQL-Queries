/*
Reichweite nach Fiege Bestand inkl. Anzahl Palettenplätze.

Depricated:

select	ile.[Item No_]
	, i.Description
	, case 
		when abs(sum(ile.Quantity))/4 > 0 then abs(sum(ile.Quantity))/4 
		else 0 end as Mittlerer_Wochenverbrauch
from [Urban-Brand GmbH$Item Ledger Entry] ile
join [Urban-Brand GmbH$Item] i
 on i.No_=ile.[Item No_]
where [Document Type] = 1
and datediff(dd,[Document Date], getdate()) < 28
group by [Item No_], i.Description
order by abs(sum(Quantity))/4 desc


*/

select 	b.No_
	, i.Description
	, i.[Description 2]
	, cast(i.[Unit Cost] * sum(b.Quantity) as decimal(10,2)) as EK
	, cast(d.Mittlerer_Wochenbedarf_letzte_12_Wochen as decimal(10,2)) as Mittlerer_Wochenbedarf
	, count(b.LE_Nr) as Palettenplätze
	, sum(b.Quantity) as Quantity
	, case 
		when d.Mittlerer_Wochenbedarf_letzte_12_Wochen = 0 then cast(sum(b.Quantity) as decimal(10,2)) 
		else cast(sum(b.Quantity)/d.Mittlerer_Wochenbedarf_letzte_12_Wochen as decimal(10,2)) end as Reichweite
from BI_DATA.dbo.OPS_Fiege_Palettenbestand b
join [Urban-Brand GmbH$Item] i
	on i.No_ = b.No_ collate Latin1_General_100_CS_AS
join ZAP_export.dbo.DispositionVerteilung_neu d
	on d.EAN = b.No_
group by b.No_
	, i.Description
	, i.[Description 2]
	, i.[Unit Cost]
	, d.Mittlerer_Wochenbedarf_letzte_12_Wochen

Having count(b.LE_Nr) > 8 and 
case when d.Mittlerer_Wochenbedarf_letzte_12_Wochen = 0 then cast(sum(b.Quantity) as decimal(10,2)) 
		else cast(sum(b.Quantity)/d.Mittlerer_Wochenbedarf_letzte_12_Wochen as decimal(10,2)) end > 13
order by Palettenplätze desc, Reichweite desc