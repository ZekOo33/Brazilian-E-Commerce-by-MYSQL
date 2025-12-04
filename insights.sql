SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM olist_orders AS o
JOIN olist_order_items AS oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
-- 2 
SELECT 
    oi.product_id,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM olist_order_items AS oi
JOIN olist_orders AS o ON oi.order_id = o.order_id
GROUP BY oi.product_id
ORDER BY total_revenue DESC;
-- 3
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY month
ORDER BY avg_delivery_days DESC;
-- 4
SELECT 
    DATE_FORMAT(r.review_creation_date, '%Y-%m') AS month,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM olist_reviews AS r
GROUP BY month
HAVING avg_review_score < 3
ORDER BY month;
-- 5
SELECT 
    c.customer_state,
    ROUND(SUM(oi.price) / COUNT(DISTINCT c.customer_id), 2) AS avg_revenue_per_customer
FROM olist_customers AS c
JOIN olist_orders AS o ON c.customer_id = o.customer_id
JOIN olist_order_items AS oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY avg_revenue_per_customer DESC
LIMIT 10;
-- 6
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders AS o
JOIN olist_order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY month
ORDER BY month;
-- 7
SELECT 
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM olist_customers AS c
JOIN olist_orders AS o ON c.customer_id = o.customer_id
JOIN olist_order_items AS oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_revenue DESC;
-- 8
SELECT 
    DAYNAME(order_purchase_timestamp) AS day_of_week,
    COUNT(order_id) AS total_orders
FROM olist_orders
GROUP BY day_of_week
ORDER BY total_orders DESC;
-- 9
SELECT 
    COUNT(*) AS repeat_customers,
    ROUND(COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM olist_customers) * 100, 2) AS percent_of_customers
FROM (
    SELECT customer_id
    FROM olist_orders
    GROUP BY customer_id
    HAVING COUNT(order_id) > 1
) AS sub;



