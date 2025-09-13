/* 
 Script: Time_Trend.sql
 Layer: OLTP (3NF normalized)
 Purpose: Generate time-based insights on revenue trends.
 
 Queries:
   1. Revenue by day
   2. Revenue by month with 7-day moving average
   3. Day-of-week pattern
   4. Peak hour of the day
 Usage:
    Detect seasonal/weekly trends, identify peak sales hours,
     and support staffing/marketing decisions.
 */


-- 4.1 Revenue by day
SELECT transaction_date AS day,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY day
ORDER BY day;

-- 4.2 Revenue by month + 7-day moving average on daily series
WITH daily AS (
  SELECT transaction_date AS day,
         SUM(line_revenue) AS revenue
  FROM v_lines
  GROUP BY day
)
SELECT day,
       revenue,
       ROUND(AVG(revenue) OVER (ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS rev_ma7
FROM daily
ORDER BY day;

-- 4.3 Day-of-week pattern
SELECT TO_CHAR(transaction_date, 'Dy') AS dow,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY dow
ORDER BY MIN(transaction_date);

-- 4.4 Peak hour of day
SELECT EXTRACT(HOUR FROM transaction_time) AS hour_of_day,
       SUM(line_revenue) AS revenue
FROM v_lines
GROUP BY hour_of_day
ORDER BY hour_of_day;
