USE SCHEMA workspace.sales_project;

CREATE OR REPLACE TABLE orders_silver
USING DELTA
AS
SELECT DISTINCT
    TRIM(order_id) AS order_id,
    TRIM(customer_id) AS customer_id,
    TRIM(customer_name) AS customer_name,
    TRIM(city) AS city,
    TRIM(product) AS product,
    CAST(quantity AS INT) AS quantity,
    CAST(unit_price AS DECIMAL(12,2)) AS unit_price,
    CAST(order_date AS DATE) AS order_date,
    TRIM(status) AS status,
    CAST(total_amount AS DECIMAL(14,2)) AS total_amount
FROM orders_bronze
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND product IS NOT NULL
  AND quantity > 0
  AND unit_price > 0;

SELECT COUNT(*) AS silver_record_count FROM orders_silver;
SELECT * FROM orders_silver ORDER BY order_id;
