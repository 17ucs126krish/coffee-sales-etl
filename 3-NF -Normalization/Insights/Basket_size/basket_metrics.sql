/*
 Script: basket_metrics.sql
 Layer: OLTP (3NF normalized)
 Purpose: Analyze basket size and order value per transaction.
 
 Queries:
   1. Average items per transaction
   2. Average order value (AOV)
   
 Usage:
     Understand customer purchase behavior and 
     average spend per visit, useful for pricing & promotions.
*/
--5.1 items in basket per transaction

WITH basket AS (
  SELECT transaction_id, 
  SUM(transaction_qty)::int AS items_in_basket
  FROM transaction_items
  GROUP BY transaction_id
),
aov AS (
  SELECT AVG(revenue)::numeric(12,2) AS avg_order_value
  FROM v_txn_revenue
)
SELECT 
  AVG(items_in_basket)::numeric(10,2) AS avg_items_per_txn_precise,   
  ROUND(AVG(items_in_basket)) AS avg_items_per_txn,           
  (SELECT avg_order_value 
  FROM aov) AS avg_order_value                
FROM basket;