/*
-> Script: Null rule.sql
-> Layer: OLTP (3NF normalized)
-> Purpose: Enforce referential integrity checks

-> Why check only the transactions table?
-- --------------------------------------
-> In the 3NF OLTP model, the transactions table is the central "fact-like" table.
-> It connects to multiple parent (dimension-like) tables such as:
          
		  - stores
          - customers
          - employees
          - products (via transaction_items)
		  
If foreign keys in the transactions table are valid, then it ensures that each transaction has a valid store,
and by extension that all related dimension tables are properly referenced (no orphaned records).

-> Here we start with checking store_id, since each transaction must always belong to a valid store.
*/

SELECT t.*
FROM transactions as t 
LEFT JOIN stores as s 
ON t.store_id = s.store_id 
WHERE s.store_id IS NULL;