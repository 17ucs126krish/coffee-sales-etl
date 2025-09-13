/* 
 Script: Category_Mix.sql
 Layer: OLTP (3NF normalized)
 Purpose: Analyze sales by category and price band.
 
 Queries:
   1. Revenue by category
   2. Category share by store
   3. Price band revenue mix (<$3, $3–$5, >=$5)
   
 Usage:
     Understand which categories and price ranges 
     contribute most to revenue across stores.
*/

-- 3.1 Revenue by category
SELECT product_category AS category,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY category
ORDER BY revenue DESC;

-- 3.2 Category share by store
WITH mix AS (
  SELECT store_location, product_category,
         SUM(line_revenue) AS revenue
  FROM v_lines
  GROUP BY store_location, product_category
),
tot AS (
  SELECT store_location, SUM(revenue) AS store_total
  FROM mix GROUP BY store_location
)
SELECT m.store_location AS store,
       m.product_category AS category,
       ROUND(100.0 * m.revenue / t.store_total, 2) AS pct_in_store
FROM mix m
JOIN tot t 
ON t.store_location = m.store_location
ORDER BY store, pct_in_store DESC;

-- 3.3 Price band mix 
SELECT CASE
          WHEN unit_price < 3 THEN 'Low (<$3)'
          WHEN unit_price < 5 THEN 'Mid ($3-$5)'
          ELSE 'High (>= $5)'
       END AS price_band,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY price_band
ORDER BY revenue DESC;
