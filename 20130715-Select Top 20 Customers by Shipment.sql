/* select top 20 shipping addresses by shipments in last month */

select distinct top 20 sh.[Ship-to Address] as "Address", sh.[Ship-to City], COUNT(sh.[Shipment Date]) as "Shipments"
from [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Header] as sh
where MONTH(sh.[Shipment Date]) >= MONTH (Getdate()) 
group by sh.[Ship-to City],[Ship-to Address],sh.[Ship-to Address 2],sh.[Ship-to Code]
order by COUNT(sh.[Shipment Date]) desc;


/*** Attribut 5´has KW and Klasse in A,B,C ***/

select No_,Description,[Attribute 5], Klasse from dbo.[Urban-Brand GmbH$Item]
where upper([Attribute 5]) like '%KW%'
and Klasse in ('A','B','C');
