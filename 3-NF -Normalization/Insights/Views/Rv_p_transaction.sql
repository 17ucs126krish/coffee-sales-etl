/* 

 Script: Rv_p_transaction.sql
 Layer: OLTP (3NF normalized)
 Purpose: Creates a transaction-level revenue view (v_txn_revenue)
 
 Output:
   Aggregated revenue per transaction.
   
 Usage:
    Used in further enrichment of transaction headers
     and calculating AOV (average order value).
*/

CREATE OR REPLACE VIEW v_txn_revenue as
SELECT ti.transaction_id,
  SUM(ti.transaction_qty * p.unit_price) as revenue
FROM transaction_items as ti
JOIN products p on p.product_id = ti.product_id
GROUP BY ti.transaction_id;