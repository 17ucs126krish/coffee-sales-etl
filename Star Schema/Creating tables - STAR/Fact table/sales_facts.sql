/*

Script: sales_facts.sql
Layer: OLAP (Star Schema)
Purpose: Create the fact_sales table at the grain of
         date_key × store_id × product_id
Measures: transaction quantity and revenue

*/

--Fact Table (uses natural keys store_id/product_id)
CREATE TABLE fact_sales_nk (
  date_key   DATE NOT NULL REFERENCES dim_date(date_key),
  store_id   INT  NOT NULL REFERENCES stores(store_id),
  product_id INT  NOT NULL REFERENCES products(product_id),
  qty        INT  NOT NULL,
  revenue    NUMERIC(14,2) NOT NULL,
  PRIMARY KEY (date_key, store_id, product_id)
);

INSERT INTO fact_sales_nk (date_key, store_id, product_id, qty, revenue)
SELECT
  t.transaction_date AS date_key,
  t.store_id,
  ti.product_id,
  SUM(ti.transaction_qty) AS qty,
  SUM(ti.transaction_qty * p.unit_price)::NUMERIC(14,2) AS revenue
FROM transaction_items ti
JOIN transactions t
ON t.transaction_id = ti.transaction_id
JOIN products p     
ON p.product_id = ti.product_id
GROUP BY t.transaction_date, t.store_id, ti.product_id;