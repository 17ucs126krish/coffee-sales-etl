/* 

 Script: Detail_Product_Attributes.sql
 Layer: OLTP (3NF normalized)
 Purpose: Creates a line-level view (v_lines) enriched with 
 product attributes and revenue calculation.
 
 Output: 
   Transaction detail with store, product, quantity, unit price, and line revenue.
   
 Usage: 
   Forms the base for product performance, category mix, 
     store revenue analysis, and basket metrics.
*/

CREATE OR REPLACE VIEW v_lines as
SELECT t.transaction_id,
       t.transaction_date,
	   t.transaction_time,
	   s.store_location,
	   p.product_id,
	   p.product_detail,
	   p.product_type,
	   p.product_category,
	   ti.transaction_qty,
	   p.unit_price,
       ti.transaction_qty * p.unit_price as line_revenue
FROM transaction_items  as ti
JOIN transactions as t 
on t.transaction_id = ti.transaction_id
JOIN stores as s 
on s.store_id = t.store_id
JOIN products as p
on p.product_id = ti.product_id;