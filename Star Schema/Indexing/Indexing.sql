/*
Script: Indexing.sql
Layer: OLAP (Star Schema)
Purpose: Create indexes on the fact_sales_nk table 
         to improve query performance in analytics.
Indexes:
  - ix_factnk_date → filters & aggregations by date
  - ix_factnk_store → store-level performance queries
  - ix_factnk_prod → product-level analysis

*/


--Indexing helps us to retrive data faster
CREATE INDEX IF NOT EXISTS ix_factnk_date  ON fact_sales_nk(date_key);
CREATE INDEX IF NOT EXISTS ix_factnk_store ON fact_sales_nk(store_id);
CREATE INDEX IF NOT EXISTS ix_factnk_prod  ON fact_sales_nk(product_id);
