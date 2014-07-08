SELECT
sih.[Order No_],
nps.Kommentar,
score
 
  FROM [MAG_BI_Import].[dbo].[mage_nps] nps
 
  left join Urban_NAV600_SL.dbo.[Urban-Brand GmbH$Sales Invoice Header] sih        
      on nps.vkr = sih.No_ collate Latin1_General_100_CS_AS
     
      where nps.score < 8     
      and DATEDIFF(week,last_update, GETDATE()) = 1 and Kommentar <>  ' '
      and nps.[Reason Code] = 'WINDELN_DE'
     
order by last_update desc