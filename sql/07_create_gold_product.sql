USE SCHEMA workspace.sales_project;

CREATE OR REPLACE TABLE sales_gold_by_product
USING DELTA
AS
SELECT product,
       COUNT(*) AS total_orders,
       SUM(quantity) AS total_quantity,
       SUM(total_amount) AS total_sales
FROM orders_silver
GROUP BY product;

SELECT * FROM sales_gold_by_product ORDER BY total_sales DESC;
