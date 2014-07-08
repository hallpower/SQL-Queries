DECLARE @fromdate DATETIME = '2014-03-28 00:00:00'
DECLARE @todate DATETIME = '2014-04-30 23:59:59';

with
orderdate as
(
SELECT     sh.[No_] as OrderID
          , sh.[File No_] as FileID
          , dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as SendTimestamp
          , case
               when cast(BI_Staging.dbo.NextWorkingDayWA(ffp.[Timestamp Upload_Download]) as date) > CAST (dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as date) then 8
               when cast(dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as time) <= '08:00' then 8
               when cast(dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as time) <= '12:00' then 12
               when cast(dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as time) <= '16:00' then 16
               when cast(dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as time) <= '17:00' then 17
               else 8 end as TimeCluster -- 8AM + 24hrs
          , case
               when cast(dateadd(hh, 2, ffp.[Timestamp Upload_Download]) as time) > '17:00' then cast(BI_Staging.dbo.NextWorkingDayWA(dateadd(dd, 1, ffp.[Timestamp Upload_Download])) AS Date)
               else cast(BI_Staging.dbo.NextWorkingDayWA(ffp.[Timestamp Upload_Download]) as DATE) End as DateCluster2
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFSalesHeader] sh with (nolock)
join [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$eBayFFProtocol] ffp with (nolock)
on ffp.[File No_] = sh.[File No_]
where dateadd(hh, 2, ffp.[Timestamp Upload_Download]) between @fromdate and @todate
and sh.[Setup Code] = 'FIEGE' --sh.[File No_] like 'A3%'
and sh.[Sell-to Customer No_] not in ('D1164626','D1173541')
and sh.No_ not like 'A9%'
and sh.Type = 0
),
fulfillmentdate as
(
select     OrderID collate Latin1_General_100_CS_AS as OrderID
          , max(KnownToPostalServiceTimestamp) as KnownToPostalService
from [MAG_BI_Import].[dbo].[dlz_malus_BER] with (nolock)
where KnownToPostalServiceTimestamp > @fromdate
group by OrderID
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


left outer join fulfillmentdate 
on fulfillmentdate.OrderID = orderdate.OrderID
where orderdate.DateCluster2 between '2013-07-01' and '2013-07-31'
order by SendTimestamp asc