/*
Pipeline Report
Determine source of errors in transmission from webshop to fulfillment
*/

SELECT count(sh.[Account No]) as AccountsNotProcessedinTransfer

FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Create_UpdateAccount] as sh with (NOLOCK)
LEFT Outer JOIN Urban_NAV600_SL.dbo.[Urban-Brand GmbH$AccountResponse] AS sr ON sr.[Entry No_] = sh.[Entry No_]
Where sr.[Entry No_] IS NULL

SELECT cast (sh.[OrderDate] as Date) as Datum, count (sh.[ExternalDocumentNo] ) as OrdersNotPorcessedinTransfer
FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$CreateDocumentHeader] as sh with (NOLOCK)
LEFT Outer JOIN Urban_NAV600_SL.dbo.[Urban-Brand GmbH$CreateDocumentResponse] AS sr ON sr.[Entry No_] = sh.[Entry No_]
Where sr.[Entry No_] IS NULL AND sh.Completed = 1
Group By cast (sh.[OrderDate] as Date) 
order by "Datum" asc

SELECT --cast([Posting Date] as Date) as Datum, 
count(No_) as OrdersNotSent2Log
FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader]
Where [Document Type] = 12 AND [Status Fulfillment] = 0 And [Processing Status] = 0
--Group By cast([Posting Date] as Date)

SELECT [Purchaser Code]
,cast([Posting Date] as Date) as Datum
,count(No_) as PurchasesNotSent2Log 

FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFPurchaseHeader]
Where [Processing Status] = 0 and [Document Type] = 1 And [Status Fulfillment] = 0
Group by [Purchaser Code], cast([Posting Date] as Date)

SELECT count ([Entry No_]) As ResponseError
FROM [urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFXML]
Where Status = 4



--DECLARE @fromdate DATETIME = '2014-01-23 07:00'
--DECLARE @todate DATETIME = getdate() 


--SELECT sh.[File No_]
--, dateadd(hh, 1, ffp.[Timestamp Upload_Download])
--, count(sh.[No_])
--FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh
--join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp
--on ffp.[File No_] = sh.[File No_]
--where ffp.[Timestamp Upload_Download] between @fromdate and @todate
--and sh.[File No_] like 'A6%'
--group by sh.[File No_]
--, ffp.[Timestamp Upload_Download]
--order by ffp.[Timestamp Upload_Download]