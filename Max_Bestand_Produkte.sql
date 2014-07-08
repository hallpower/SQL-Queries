with 
a as 
(SELECT     
EAN,  
cast(InStorage as int) as InStorage


FROM	History.dbo.ItemLedgerEntryAggr AS ilea with (nolock)
Where ilea.EAN != '4008976022343' 
AND ilea.[Location Code] != 'WINDELBAR'

union

SELECT     
EAN, 
InStorage

FROM	BI_Data.dbo.ItemLedgerEntryAggr AS ilea with (nolock)
where ilea.EAN != '4008976022343' 
AND ilea.[Location Code] != 'WINDELBAR')

select	EAN
		, MAX(InStorage) 
	as Bestand from a
group by EAN