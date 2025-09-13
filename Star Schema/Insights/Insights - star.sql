/*
Script: Insights - star.sql
Layer: OLAP (Star Schema)
Purpose: Business insights generated from the fact_sales_nk table

Includes:
  1) Store performance → revenue by store
  2) Product performance → top-selling products by qty & revenue
  3) Time trends → monthly revenue trend

*/

--1) Store Performance
-- Revenue by store (star)

SELECT s.store_location AS store,
       SUM(f.revenue)   AS revenue
FROM fact_sales_nk f
JOIN stores s
ON s.store_id = f.store_id
GROUP BY s.store_location
ORDER BY revenue DESC;

--2) Product Performance
-- Best selling products (top by revenue/quantity) - (Star)

SELECT p.product_category,
       p.product_detail,
       SUM(f.qty) AS total_qty,
       SUM(f.revenue)::numeric(12,2) AS total_revenue
FROM fact_sales_nk f
JOIN products p 
ON f.product_id = p.product_id
GROUP BY p.product_category, p.product_detail
ORDER BY total_revenue desc;

--3) Time Trends
--Sales trend over time (monthly).
SELECT d.year, 
      d.month, 
	  d.month_name,
      SUM(f.revenue)::numeric(12,2) AS monthly_revenue
FROM fact_sales_nk f
JOIN dim_date d
ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;