/****** Query to find inventroy in Lager at given date  ******/

SELECT il.[Item No_]
      ,Sum (il.[Quantity] ) as Quantity
     , it.Description
  FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry] as il
     join [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item] as it
on il.[Item No_] = it.No_
  WHERE il.[Location Code] = 'BER_FIEGE'
  and il.[Posting Date] <= '2013-08-31'

  Group By il.[Item No_], it.Description
Having Sum (il.[Quantity] ) > 0
Order by Sum (il.[Quantity] ) asc

--select top 10 * from [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry]
--select top 10 * from [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry]