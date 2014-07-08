DECLARE @fromdate DATETIME = '2013-12-31 00:00:00'
DECLARE @todate DATETIME = '2014-01-31 23:59:59';

with
orderdate as
(
SELECT     sh.[No_] as OrderID
          , sh.[File No_] as FileID
          , dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as SendTimestamp
          , case
               when cast(BI_Staging.dbo.NextWorkingDayWA(dateadd(hh, 1, ffp.[Timestamp Upload_Download])) AS Date) <> CAST (dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as date) then 6
               when cast(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as time) <= '06:00' then 6
               when cast(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as time) <= '10:00' then 10
               when cast(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as time) <= '14:00' then 14
               when cast(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as time) <= '15:00' then 15
               else 6 end as TimeCluster -- 8AM + 24hrs
          , case
               when cast(dateadd(hh, 1, ffp.[Timestamp Upload_Download]) as time) > '15:00' then cast(BI_Staging.dbo.NextWorkingDayWA(dateadd(day, 1, dateadd(hh, 1, ffp.[Timestamp Upload_Download]))) AS Date)
               else cast(BI_Staging.dbo.NextWorkingDayWA(dateadd(hh, 1, ffp.[Timestamp Upload_Download])) as DATE) End as DateCluster2
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh with (nolock)
join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp with (nolock)
on ffp.[File No_] = sh.[File No_]
where dateadd(hh, 1, ffp.[Timestamp Upload_Download]) between @fromdate and @todate
and sh.[Setup Code] = 'BER_FIEGE' 
and sh.[File No_] like 'A6%'
and sh.[Sell-to Customer No_] not in ('D1164626','D1173541')
and sh.Type = 0
),
fulfillmentdate as
(
select	No_ as OrderID
		, [Posting Date] as KnownToPostalService
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader]
where [Status Fulfillment] = 3
and Type = 1
and [Location Code] = 'BER_FIEGE'
and [Shipment Date] > dateadd(dd,-10,@fromdate)
)

select     orderdate.OrderID
          , orderdate.FileID
          , orderdate.SendTimestamp
          , orderdate.DateCluster2 as UploadDateCluster
          , orderdate.TimeCluster
          , fulfillmentdate.KnownToPostalService as Fulfilled
          , BI_Staging.dbo.SkipHolidays_bradenburg(orderdate.DateCluster2, fulfillmentdate.KnownToPostalService) as ServiceLevel
          , case
               when BI_Staging.dbo.SkipHolidays_bradenburg(orderdate.DateCluster2, fulfillmentdate.KnownToPostalService) > 0 then 1
               else 0
          end as Malus
from Orderdate


left outer join fulfillmentdate on fulfillmentdate.OrderID = orderdate.OrderID
--where fulfillmentdate.KnownToPostalService > orderdate.SendTimestamp
order by orderdate.SendTimestamp
