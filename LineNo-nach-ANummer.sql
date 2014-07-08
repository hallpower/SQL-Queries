Select sh.[Order No_], sl.No_, sl.[Line No_]

From [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Invoice Header] as sh
Join [urban_NAV600].[dbo].[Urban-Brand GmbH$Sales Invoice Line] as sl
on sl.[Document No_] = sh.No_
Where sh.[Order No_] in ('A0000916615')