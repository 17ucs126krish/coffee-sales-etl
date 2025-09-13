
/*
Script: QA.sql
Layer: OLAP (Star Schema) – validation using 3NF source
Purpose:
  1) Count rows in dim_date and fact_sales_nk
  2) Validate revenue parity: 3NF (items × price) vs Star (fact)
*/


--Row counts
SELECT COUNT(*) 
AS dim_date_rows   
FROM dim_date;


SELECT COUNT(*) 
AS fact_rows  
FROM fact_sales_nk;

--Revenue parity: should match
SELECT
  (SELECT SUM(ti.transaction_qty * p.unit_price)
     FROM transaction_items ti 
	 JOIN products p 
	 USING (product_id))::NUMERIC(14,2) AS revenue_3nf,
  (SELECT SUM(revenue) FROM fact_sales_nk)::NUMERIC(14,2) AS revenue_star;
