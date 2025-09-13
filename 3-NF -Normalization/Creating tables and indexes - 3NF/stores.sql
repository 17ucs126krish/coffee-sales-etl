/*
-> Script: stores.sql
-> Purpose: Create the Stores table as part of the OLTP layer
-> Layer: OLTP (3NF normalized)
-> Note: This is NOT a star schema dimension table yet.
-> In OLTP, we normalize to remove duplication and ensure data integrity before reshaping into OLAP.
*/
CREATE TABLE stores (
  store_id INT PRIMARY KEY,
  store_location VARCHAR(100) NOT NULL
);


INSERT INTO stores
SELECT DISTINCT store_id, store_location FROM raw_sales;


Select * 
from stores;
