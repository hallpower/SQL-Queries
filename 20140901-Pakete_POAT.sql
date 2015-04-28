/*
Pakete der POAT mit Land und Gewicht. 
*/

select 	p.[Order No_]
		, sh.[Ship-to Country_Region Code]
		, p.[T&T-Id]
		, p.Weight
from urban_nav600_SL.dbo.[urban-brand gmbH$eBayParcel] p
join urban_nav600_SL.dbo.[urban-brand gmbH$eBayFFSalesHeader] sh
	on sh.No_ = p.[Order No_]
where p.[T&T-Id] like '1022555%'
group by p.[Order No_]
		, sh.[Ship-to Country_Region Code]
		, p.[T&T-Id]
		, p.Weight