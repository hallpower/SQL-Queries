select	sh.[External Document No_]
		, sl.[Document No_]
		, sl.[Line No_]
		, sl.No_
		, sl.Description
		, sl.[Description 2]
		, cast(sl.Quantity as int) as Quantity
		, sl.[Unit Price]
		, sl.[Line Discount %]
		, sl.[VAT %]
		, sl.Amount
		, sl.[Amount Including VAT]
from Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesLine] sl
join Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayFFSalesHeader] sh
	on (sh.No_ = sl.[Document No_] and sh.[Entry No_] = sl.[Document Entry No_])
where sh.[External Document No_] = '1002531813'
	and sh.Type = 0