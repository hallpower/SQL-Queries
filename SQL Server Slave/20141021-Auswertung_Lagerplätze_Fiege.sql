WITH b AS
(
SELECT 	EAN
		, isnull([January], 0) as January
		, isnull([February], 0) as February
		, isnull([March], 0) as March
		, isnull([April], 0) as April
		, isnull([May], 0) as May
		, isnull([June], 0) as June
		, isnull([July], 0) as July
		, isnull([August], 0) as August
		, isnull([September], 0) as September
		, isnull([October], 0) as October
		, isnull([November], 0) as November
from 
	(
	Select	EAN as EAN
			, datename(month, DateValue) as Inv_Month
			, InStock as Stock
	from BI_Data.dbo.ItemLedgerEntryAggr with (nolock)
	where DateValue between '2014-01-01' and '2014-11-30'
	and [Location Code] = 'FIEGE'

	UNION

	Select	EAN as EAN
			, datename(month, DateValue) as Inv_Month
			, InStorage as Stock
	from BI_Data.dbo.ItemLedgerEntryAggr2 with (nolock)
	where DateValue between '2014-01-01' and '2014-11-30'
	and [Location Code] = 'Fiege'
	) 
as rawdata

PIVOT

(
max(Stock)
FOR 

[Inv_Month]

IN 
(
	[January]
	, [February]
	, [March]
	, [April]
	, [May]
	, [June]
	, [July]
	, [August]
	, [September]
	, [October]
	, [November]
)
) as pivotdata
)

select b.EAN
		, m.Description
		, m.Laenge
		, m.Breite
		, m.Hoehe
		, m.Volumen_L
		, b.January as Jan_Bes
		, b.February as Feb_Bes
		, b.March as Mar_Bes
		, b.April as Apr_Bes
		, b.May	as May_Bes
		, b.June as Jun_Bes
		, b.July as Jul_Bes
		, b.August as Aug_Bes
		, b.September as Sep_Bes
		, b.October as Oct_Bes
		, b.November as Nov_Bes
		, BI_DATA.dbo.getlagerplatz(b.January, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Jan_LP
		, BI_DATA.dbo.getlagerplatz(b.February, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Feb_LP
		, BI_DATA.dbo.getlagerplatz(b.March, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Mar_LP
		, BI_DATA.dbo.getlagerplatz(b.April, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Apr_LP
		, BI_DATA.dbo.getlagerplatz(b.May, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as May_LP
		, BI_DATA.dbo.getlagerplatz(b.June, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Jun_LP
		, BI_DATA.dbo.getlagerplatz(b.July, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Jul_LP
		, BI_DATA.dbo.getlagerplatz(b.August, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Aug_LP
		, BI_DATA.dbo.getlagerplatz(b.September, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Sep_LP
		, BI_DATA.dbo.getlagerplatz(b.October, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Oct_LP
		, BI_DATA.dbo.getlagerplatz(b.November, m.Volumen_L, m.Laenge, m.Breite, m.Hoehe) as Nov_LP
from b
join BI_Data.dbo.OPS_Fiege_Morphologie_nov2014 m with (nolock)
	on b.EAN = m.EAN
