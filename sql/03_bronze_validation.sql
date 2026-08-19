USE SCHEMA workspace.sales_project;

SELECT COUNT(*) AS total_records FROM orders_bronze;

SELECT order_id, COUNT(*) AS record_count
FROM orders_bronze
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
  SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
  SUM(CASE WHEN product IS NULL THEN 1 ELSE 0 END) AS null_product,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
  SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price
FROM orders_bronze;

SELECT * FROM orders_bronze WHERE quantity <= 0;
SELECT * FROM orders_bronze WHERE unit_price <= 0;
