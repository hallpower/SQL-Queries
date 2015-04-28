select	No_
		, ph.[File No_]
		, p.[Timestamp Upload_Download]
		, p.Message
from Urban_NAV600.dbo.[Urban-Brand GmbH$eBayFFPurchaseHeader] ph
left join Urban_NAV600.dbo.[Urban-Brand GmbH$eBayFFProtocol] p  
	on p.[File No_]=ph.[File No_]
where ph.[Location Code] = 'BER_FIEGE'  
	and ph.[Processing Status] = 0  
	and ph.[Status Fulfillment] = 1
	and p.[Timestamp Upload_Download] >= '2014-01-01'