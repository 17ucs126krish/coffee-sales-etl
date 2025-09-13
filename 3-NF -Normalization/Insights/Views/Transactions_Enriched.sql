/*

 Script: Transactions_Enriched.sql
 Layer: OLTP (3NF normalized)
 Purpose: Creates an enriched transaction header view (v_txn).
 
 Output:
  Transaction metadata (date, time, store) with total revenue.
  
 Usage:
  Supports store performance, time trend, and basket insights.
  
 */


CREATE OR REPLACE VIEW v_txn as
SELECT t.transaction_id,
       t.transaction_date,
	   t.transaction_time,
	   t.store_id,
	   s.store_location,
	   r.revenue
FROM transactions as t
JOIN stores s ON s.store_id = t.store_id
JOIN v_txn_revenue as r 
on r.transaction_id = t.transaction_id;