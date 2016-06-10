select top 10 *
from Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayNavCSalesHeader] ncsh with (nolock)
join Urban_Nav600_SL.dbo.[Urban-Brand GmbH$eBayNavCSalesLine] ncsl with (nolock)
  on ncsh.No_ = ncsl.[Document No_]
where ncsh.[Shop Code] = 'WINDELBAR'
	and ncsh.[Order Date] between '2015-08-01' and '2015-08-31'


