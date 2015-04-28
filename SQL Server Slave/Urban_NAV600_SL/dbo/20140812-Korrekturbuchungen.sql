/*
Korrekturbuchungen. 
*/

DECLARE @fromdate DATETIME = '2014-07-01'          
DECLARE @todate DATETIME = '2014-07-31'                   

Select cast(datepart(ww, fa.Date) as int) as Adjustment_wk
	, sum(fa.Quantity) as AnzahlVerarbeitet  

from urban_NAV600_SL.dbo.[Urban-Brand GmbH$Fulfillment Adjustment]  as fa  

join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Item] as it  
	on it.No_ = fa.[Item No_]  
Where [Fulfillment Setup Code] = 'BER_FIEGE'  
	AND [Generated at] between @fromdate and @todate  AND Processed = 1
	and fa.[Return Reason Code] = 'K06'
group by cast (datepart(ww, fa.Date) as int)