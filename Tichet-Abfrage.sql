select     substring(title, patindex('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%', title)+1, 7) as po_id
          , tn
          , title
          , create_time
          , customer_user_id
          , queue_id
from OTRS_Staging.dbo.OTRS_ticket with (nolock)
where title like ('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%')
and substring(title, patindex('%[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]%', title)+1, 7)
in(
 SELECT right(prh.[Order No_],7) collate Latin1_General_CI_AS
FROM [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Purch_ Rcpt_ Header] AS prh
LEFT JOIN [Urban_NAV600_SL].[dbo].[Urban-Brand GmbH$Item Ledger Entry] AS prl ON prl.[Document No_]=prh.[No_]
WHERE prl.[Posting Date] BETWEEN '2013-10-01' AND '2013-10-31'
  AND LEFT(prh.[Order No_],4) NOT LIKE ('UMLG')
  AND prh.[Group7 Reference] NOT LIKE ('UMZUG')
GROUP BY prh.[Order No_]
)
and user_id in(
select OTRS_group_user.USER_ID  from OTRS_Staging..OTRS_group_user
inner join OTRS_Staging..OTRS_groups on OTRS_group_user.group_id = OTRS_groups.id 
where OTRS_groups.name = 'Fiege'
) 
and
DATEDIFF (MM,create_time,GETdate())<6


