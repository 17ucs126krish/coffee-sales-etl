/* 
 Script: s_performance.sql
 Layer: OLTP (3NF normalized)
 Purpose: Generate store-level performance insights.
 
 Queries:
   1. Total revenue by store
   2. Revenue share % by store
   3. Monthly revenue by store (trend/heatmap-friendly)
   4. Top product per store
 Usage:
   - Helps benchmark stores, identify high performers,
     and optimize product placement by location.
*/

-- 1.1 Total revenue by store
Select store_location,
       sum(line_revenue) as "revenue"
from v_lines
group by store_location
order by revenue desc;

-- 1.2 Revenue share (%) by store
with store_rev as (
  Select store_location,
         sum(line_revenue) as "revenue"
from v_lines
group by store_location
order by revenue desc
),
tot as 
(Select sum(revenue) as total 
FROM store_rev
)
Select s.store_location as "store",
       s.revenue,
       ROUND(100.0 * s.revenue / t.total, 2) as "total%"
from store_rev as s 
cross join tot as t
order by revenue DESC;

-- 1.3 Monthly revenue by store 
Select DATE_TRUNC('month', transaction_date)::date as "month_start",
       store_location,
       sum(line_revenue) as "revenue"
FROM v_lines
GROUP BY month_start, store_location
ORDER BY month_start, store_location;

-- 1.4 Top product per store
SELECT store_location, product_detail, revenue
FROM (
  SELECT store_location, product_detail,
         SUM(line_revenue) AS "revenue",
         ROW_NUMBER() OVER (PARTITION BY store_location ORDER BY SUM(line_revenue) DESC) AS "rn"
  FROM v_lines
  GROUP BY store_location, product_detail
) x
WHERE rn = 1
ORDER BY revenue DESC;
