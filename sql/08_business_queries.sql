USE SCHEMA workspace.sales_project;

-- Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders_silver;

-- Completed revenue
SELECT SUM(total_amount) AS completed_revenue
FROM orders_silver WHERE status = 'Completed';

-- Orders by status
SELECT status, COUNT(*) AS order_count
FROM orders_silver GROUP BY status ORDER BY order_count DESC;

-- Top 10 customers
SELECT customer_id, customer_name, SUM(total_amount) AS total_spent
FROM orders_silver
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- Top cities
SELECT city, SUM(total_amount) AS total_sales
FROM orders_silver
GROUP BY city
ORDER BY total_sales DESC
LIMIT 10;

-- Product revenue
SELECT product, SUM(total_amount) AS total_sales
FROM orders_silver
GROUP BY product
ORDER BY total_sales DESC;

-- Monthly sales
SELECT DATE_FORMAT(order_date, 'yyyy-MM') AS sales_month,
       SUM(total_amount) AS total_sales,
       COUNT(*) AS total_orders
FROM orders_silver
GROUP BY DATE_FORMAT(order_date, 'yyyy-MM')
ORDER BY sales_month;

-- Average order value
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders_silver;

-- Completed vs cancelled
SELECT status, COUNT(*) AS total_orders, SUM(total_amount) AS total_sales
FROM orders_silver
WHERE status IN ('Completed','Cancelled')
GROUP BY status
ORDER BY total_sales DESC;

-- Gold reports
SELECT * FROM sales_gold_by_city ORDER BY total_sales DESC;
SELECT * FROM sales_gold_by_product ORDER BY total_sales DESC;
