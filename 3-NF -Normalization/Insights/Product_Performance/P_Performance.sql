/*
 Script: P_Performance.sql
 Layer: OLTP (3NF normalized)
 Purpose: Generate product-level performance insights.
 
 Queries:
   1. Top 15 products by revenue
   2. Product leaderboard with Pareto (80/20 analysis)
   3. Product breadth (# of stores selling each product)
   
 Usage:
      Identifies hero products, validates the 80/20 rule,
     and shows product distribution across stores.

*/

-- 2.1 Top 15 products by revenue
SELECT product_detail AS "product",
       SUM(transaction_qty) AS "units_sold",
       SUM(line_revenue)    AS "revenue"
FROM v_lines
GROUP BY product
ORDER BY revenue DESC
LIMIT 15;

-- 2.2 Product leaderboard with rank & cumulative share (Pareto 80/20)
WITH prod AS (
 SELECT product_detail,
        SUM(line_revenue) AS "revenue"
 FROM v_lines
 GROUP BY product_detail
),
ranked AS (
 SELECT product_detail, revenue,
         RANK() OVER (ORDER BY revenue DESC) AS "rnk",
         SUM(revenue) OVER () AS "total_rev",
         SUM(revenue) OVER (ORDER BY revenue DESC) AS "cum_rev"
  FROM prod
)
SELECT product_detail, revenue, rnk,
       ROUND(100.0 * cum_rev / total_rev, 2) AS cum_pct
FROM ranked
ORDER BY rnk;

-- 2.3 Product breadth: # of distinct stores selling each product
SELECT product_detail,
       COUNT(DISTINCT store_location) AS stores_selling,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY product_detail
ORDER BY stores_selling DESC, revenue DESC;
