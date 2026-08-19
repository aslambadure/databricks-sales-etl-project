USE SCHEMA workspace.sales_project;

SHOW TABLES;

SELECT 'orders_bronze' AS table_name, COUNT(*) AS record_count FROM orders_bronze
UNION ALL
SELECT 'orders_silver', COUNT(*) FROM orders_silver
UNION ALL
SELECT 'sales_gold_by_city', COUNT(*) FROM sales_gold_by_city
UNION ALL
SELECT 'sales_gold_by_product', COUNT(*) FROM sales_gold_by_product;

DESCRIBE TABLE orders_bronze;
DESCRIBE TABLE orders_silver;
DESCRIBE TABLE sales_gold_by_city;
DESCRIBE TABLE sales_gold_by_product;
