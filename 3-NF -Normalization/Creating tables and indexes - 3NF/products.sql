/*
-> Script: products.sql
-> Purpose: Create the Products table as part of the OLTP layer
-> Layer: OLTP (3NF normalized)
-> Note: Holds unique product attributes, not an OLAP dimension.
*/
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_category VARCHAR(50) NOT NULL,
  product_type VARCHAR(50) NOT NULL,
  product_detail VARCHAR(100) NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL
);

TRUNCATE TABLE products RESTART IDENTITY CASCADE;

-- Products: keep the LATEST attributes per product (handles price/category changes)
INSERT INTO products (product_id, product_category, product_type, product_detail, unit_price)
SELECT DISTINCT ON (product_id)
       product_id,
	   product_category,
	   product_type, 
	   product_detail, 
	   unit_price
FROM raw_sales
WHERE product_id IS NOT NULL
ORDER BY product_id, transaction_date DESC, transaction_time DESC;
