/*
Script: Indexing.sql
-> Layer: OLTP (3NF normalized)
-> Purpose: Faster retrieval of data by creating essential indexes
*/

-- Creating index on both transactions and transactional_items table for faster retival of data 

--Creating index on transaction table
CREATE INDEX IF NOT EXISTS ix_transactions_store ON transactions(store_id);

--Creating index on transactional_items
CREATE INDEX IF NOT EXISTS ix_items_product ON transaction_items(product_id);