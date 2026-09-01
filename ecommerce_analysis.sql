SELECT COUNT(*) FROM customers;
SELECT *
FROM customers
LIMIT 5;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM orders
WHERE order_status = 'delivered'
LIMIT 10;

SELECT *
FROM orders
ORDER BY order_purchase_timestamp DESC
LIMIT 10;

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT SUM(payment_value) AS total_revenue
FROM payments;

SELECT AVG(payment_value) AS average_payment
FROM payments;

SELECT o.order_id, o.order_status, c.customer_city, c.customer_state
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
LIMIT 10;

SELECT o.order_id, o.order_status, r.review_score
FROM orders o
LEFT JOIN reviews r
ON o.order_id = r.order_id
LIMIT 10;

SELECT o.order_id, o.order_status, r.review_score
FROM orders o
RIGHT JOIN reviews r
ON o.order_id = r.order_id
LIMIT 10;

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders
)
ORDER BY total_orders DESC;

CREATE VIEW customer_order_summary AS
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT *
FROM customer_order_summary
LIMIT 10;

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

SELECT indexname
FROM pg_indexes
WHERE tablename = 'orders';

SELECT payment_type,
       SUM(payment_value) AS total_revenue
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;
