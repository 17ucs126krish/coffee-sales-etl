/*
-> Script: transaction_items.sql
-> Purpose: Create the Transaction Items table as part of OLTP
-> Layer: OLTP (3NF normalized)
-> Note: This looks like a fact table, but in OLTP it is just a junction table linking transactions and products.
*/

CREATE TABLE IF NOT EXISTS transaction_items (
  transaction_id  BIGINT NOT NULL REFERENCES transactions(transaction_id) ON DELETE CASCADE,
  product_id INT NOT NULL REFERENCES products(product_id),
  transaction_qty INT NOT NULL CHECK (transaction_qty > 0),
  PRIMARY KEY (transaction_id, product_id)
);

--
INSERT INTO transaction_items (transaction_id, product_id, transaction_qty)
SELECT transaction_id, product_id, SUM(transaction_qty)::int as total_qty
FROM raw_sales
GROUP BY transaction_id, product_id;
