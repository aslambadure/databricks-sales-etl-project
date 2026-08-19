USE SCHEMA workspace.sales_project;

CREATE OR REPLACE TABLE sales_gold_by_city
USING DELTA
AS
SELECT city,
       COUNT(*) AS total_orders,
       SUM(quantity) AS total_quantity,
       SUM(total_amount) AS total_sales
FROM orders_silver
GROUP BY city;

SELECT * FROM sales_gold_by_city ORDER BY total_sales DESC;
