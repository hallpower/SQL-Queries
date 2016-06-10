/*
This query determines all new Item Master Data for Nakiki that has been used in deals in the
previous day, which has not been in a deal since March 31st (migration date from NAV)
*/


SELECT DISTINCT sl.ITEMID
FROM AX.`PROD_DynamicsAX2012.dbo.SALESTABLE` st
JOIN "AX"."PROD_DynamicsAX2012.dbo.SALESLINE" sl
		ON sl."SALESID" = st."SALESID"
JOIN shop_orders.orders AS so
		ON so.order_id = st.customerref
WHERE st.SALESORIGINID IN ('WINDELBAR', 'NAKIKI_DE', 'NAKIKI_IT', 'WUNDERLAND')
      AND cast(so.order_date AS DATE) >= '2016-03-01'
-- AND cast(st."CREATEDDATETIME" AS DATE) >= timestampadd(SQL_TSI_DAY, -1, now())
--       AND sl."ITEMID" NOT IN
--           (
-- 		          SELECT DISTINCT sl."ITEMID" AS EAN
-- 		          FROM "AX"."PROD_DynamicsAX2012.dbo.SALESTABLE" st
-- 		          JOIN "AX"."PROD_DynamicsAX2012.dbo.SALESLINE" sl
-- 				          ON sl."SALESID" = st."SALESID"
-- 		          WHERE st.salesoriginid IN ('WINDELBAR', 'NAKIKI_DE', 'NAKIKI_IT', 'WUNDERLAND')
-- 		                AND cast(so.order_date AS DATE) > '2016-03-01'
-- 		          -- AND st."CREATEDDATETIME" < timestampadd(SQL_TSI_DAY, -1, now())
-- 		          -- AND cast(st."CREATEDDATETIME" AS DATE) >= '2016-03-31' --timestampadd(SQL_TSI_DAY, -30, now())
--           )
