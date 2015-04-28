/*
NETTO-Korrekturbuchungen von Schnittstelle
*/

DECLARE @fromdate DATETIME = '2014-10-01'          
DECLARE @todate DATETIME = '2014-10-31'                   

Select	fa.[Item No_] 
		, abs(cast(fa.Quantity as float)) as AnzahlVerarbeitet 
		, fa.[Return Reason Code]   
		, case  
			when fa.[Return Reason Code] in ('K12', 'K13', 'K14', 'K17') then (-1 * (it.[Unit Cost] * abs(cast(fa.Quantity as float))))  
			else (it.[Unit Cost] * abs(cast(fa.Quantity as float))) end as Warenwert    

from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Fulfillment Adjustment]  as fa  
join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item] as it  
	on it.No_ = fa.[Item No_]  

Where [Fulfillment Setup Code] = 'BER_FIEGE'  
	AND [Generated at] between @fromdate and @todate  
	AND Processed = 1