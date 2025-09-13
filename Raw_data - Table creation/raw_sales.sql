/* This script creates the raw_sales table, which is the base OLTP table for the project.
It defines all 11 columns from the Coffee Shop Sales dataset (149,116 rows, source: Maven Analytics), 
including transaction_id, transaction_date, store_id, product_id, unit_price,
and product attributes like category, type, and detail*/

Create table raw_sales(
transaction_id   BIGINT,
  transaction_date DATE,
  transaction_time TIME,
  transaction_qty  INT,
  store_id         INT,
  store_location   VARCHAR(100),
  product_id       INT,
  unit_price       NUMERIC(10,2),
  product_category VARCHAR(50),
  product_type     VARCHAR(50),
  product_detail   VARCHAR(100)
)