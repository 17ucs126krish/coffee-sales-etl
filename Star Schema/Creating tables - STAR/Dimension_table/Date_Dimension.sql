/*

Script: Date_Dimension.sql
Layer: OLAP (Star Schema)
Purpose: Create a date dimension from the transaction date range
Output: dim_date with attributes like year, quarter, month, day, etc.

*/

-- Star Schema (Natural Keys) from 3NF
-- Source tables: From dimenions table that I created

--Date Dimension (natural key = date)

CREATE TABLE dim_date (
  date_key   DATE PRIMARY KEY,          
  year       INT,
  quarter    INT,
  month      INT,
  day        INT,
  dow        INT,                       
  month_name TEXT,
  dow_name   TEXT,
  is_weekend BOOLEAN
);

WITH bounds AS (
  SELECT MIN(transaction_date) AS dmin, MAX(transaction_date) AS dmax
  FROM transactions
)
INSERT INTO dim_date (date_key, year, quarter, month, day, dow, month_name, dow_name, is_weekend)
SELECT d::date,
       EXTRACT(YEAR    FROM d)::INT,
       EXTRACT(QUARTER FROM d)::INT,
       EXTRACT(MONTH   FROM d)::INT,
       EXTRACT(DAY     FROM d)::INT,
       EXTRACT(DOW     FROM d)::INT,
       TO_CHAR(d, 'Mon'),
       TO_CHAR(d, 'Dy'),
       (EXTRACT(DOW FROM d) IN (0,6))
FROM bounds b,
     GENERATE_SERIES(b.dmin, b.dmax, INTERVAL '1 day') AS s(d);
