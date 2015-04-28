/* Version 2 der Query auf Item Ledger Entry Ebene, 
unter einbezug der Stk in der Beschreibung */

select	i.No_
		, ile.[Source No_]
		, i.Description
		, i.[Description 2]
		, case 
				when len(substring(i.[Description 2], 0, Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0))) > 0 
					then substring(i.[Description 2], 0, Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0))
				else i.[Description 2] end as Description_Short
		, dv.Name
		, ile.[Unit of Measure Code]
		, ile.[Posting Date]
		, ile.Quantity
		, ile.[Qty_ per Unit of Measure]
		, case 
			when cast (substring(i.[Description 2],Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)+1,PATINDEX('%[0-9] [sS][tT]%', i.[Description 2])-Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)) as int) = 0 then 1
			else cast (substring(i.[Description 2],Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)+1,PATINDEX('%[0-9] [sS][tT]%', i.[Description 2])-Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)) as int)
			end as Multiplikator
		, cast ( ile.Quantity * case 
			when cast (substring(i.[Description 2],Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)+1,PATINDEX('%[0-9] [sS][tT]%', i.[Description 2])-Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)) as int) = 0 then 1
			else cast (substring(i.[Description 2],Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)+1,PATINDEX('%[0-9] [sS][tT]%', i.[Description 2])-Urban_NAV600_SL.dbo.RegExIndex('[0-9]+\s[Ss][Tt]', i.[Description 2], 0)) as int)
			end as Int) as Stück
from urban_nav600_sl.dbo.[urban-brand GmbH$Item Ledger Entry] ile
join urban_nav600_sl.dbo.[urban-brand GmbH$Item] i
	on i.No_ = ile.[Item No_]
join Urban_Nav600_SL.dbo.[Urban-Brand GmbH$Dimension Value] dv
	on dv.Code = i.[Attribute 2]
where ile.[Source No_] in ('71009', '71990')
	and ile.[Posting Date] between '2014-12-01' and getdate()
	and ile.[Location Code] = 'BER_FIEGE'
	and i.[Attribute 2] = '201'