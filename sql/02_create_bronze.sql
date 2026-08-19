USE SCHEMA workspace.sales_project;

CREATE OR REPLACE TABLE orders_bronze
USING DELTA
AS
SELECT *
FROM csv.`/Volumes/workspace/default/sales_volume/databricks_orders_100.csv`
OPTIONS (header = "true", inferSchema = "true");

SELECT COUNT(*) AS bronze_record_count FROM orders_bronze;
SELECT * FROM orders_bronze ORDER BY order_id;
