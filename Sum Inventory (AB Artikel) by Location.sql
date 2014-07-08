/*Sum inventory of A, B Items in Loction Fiege and Ber_Fiege*/

select	i.No_,
		i.Description, 
		sum(case when l.[Location Code]='BER_FIEGE' then l.Quantity else 0 end) as BER_FIEGE,  
		sum(case when l.[Location Code]='FIEGE' then l.Quantity else 0 end) as FIEGE

from [urban_NAV600].[dbo].[Urban-Brand GmbH$Item] as i
left join [urban_NAV600].[dbo].[Urban-Brand GmbH$Item Ledger Entry] as l
on i.No_=l.[Item No_]
where i.Klasse in ('A', 'B')
and l.[Location Code] like ('%FIEGE%')
group by i.No_, i.Description;