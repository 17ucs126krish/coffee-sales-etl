/*This script creates the raw_sales table, which is the base OLTP table for the project.
It defines all 11 columns from the Coffee Shop Sales dataset (149,116 rows, source: Maven Analytics),
including transaction_id, transaction_date, store_id, product_id, unit_price, and product attributes like category, type, and detail
*/
-- counting to check whether data is successfully loaded into the table
Select count(*) as "data_counts"
from raw_sales