/*
-> Script: transactions.sql
-> Purpose: Create the Transactions table for OLTP layer
-> Layer: OLTP (3NF normalized)
-> Note: Each transaction_id is a unique receipt.
*/

CREATE TABLE IF NOT EXISTS transactions (
  transaction_id BIGINT PRIMARY KEY,
  transaction_date DATE NOT NULL,
  transaction_time TIME NOT NULL,
  store_id INT NOT NULL REFERENCES stores(store_id)
);

--Inserts one rows pers receipt
INSERT INTO transactions (transaction_id, transaction_date, transaction_time, store_id)
SELECT DISTINCT transaction_id, transaction_date, transaction_time, store_id
FROM raw_sales
WHERE transaction_id IS NOT NULL;

