USE SCHEMA workspace.sales_project;

SELECT COUNT(*) AS total_records FROM orders_silver;

SELECT order_id, COUNT(*) AS record_count
FROM orders_silver
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_id, quantity, unit_price, total_amount,
       quantity * unit_price AS calculated_amount
FROM orders_silver
WHERE total_amount <> quantity * unit_price;

SELECT status, COUNT(*) AS order_count
FROM orders_silver
GROUP BY status
ORDER BY order_count DESC;

SELECT city, COUNT(*) AS order_count
FROM orders_silver
GROUP BY city
ORDER BY order_count DESC;
