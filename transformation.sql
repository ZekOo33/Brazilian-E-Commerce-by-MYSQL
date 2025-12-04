SET SQL_SAFE_UPDATES = 0;
-- cleaning and transformation
-- 1
update olist_customers set customer_id= upper(trim(customer_id));
update olist_customers set customer_unique_id= upper(trim(customer_unique_id));
update olist_customers set customer_city= upper(trim(customer_city));
update olist_customers set customer_state= upper(trim(customer_state));
update olist_order_items set order_id= upper(trim(order_id));
SELECT * FROM olist_customers;
-- 2
SELECT * FROM olist_orders;
update olist_orders set customer_id= upper(trim(customer_id));
update olist_orders set order_id= upper(trim(order_id));
update olist_orders set order_status= upper(trim(order_status));
ALTER TABLE olist_orders
ADD COLUMN order_purchase_dt DATETIME,
ADD COLUMN order_delivered_dt DATETIME,
ADD COLUMN order_estimated_dt DATETIME;
UPDATE olist_orders
SET order_purchase_timestamp = NULL WHERE order_purchase_timestamp = '';
UPDATE olist_orders
SET order_delivered_customer_date = NULL WHERE order_delivered_customer_date = '';
UPDATE olist_orders
SET order_estimated_delivery_date = NULL WHERE order_estimated_delivery_date = '';

UPDATE olist_orders
SET 
    order_purchase_dt = STR_TO_DATE(order_purchase_timestamp, '%d/%m/%Y %H:%i'),
    order_delivered_dt = STR_TO_DATE(order_delivered_customer_date, '%d/%m/%Y %H:%i'),
    order_estimated_dt = STR_TO_DATE(order_estimated_delivery_date, '%d/%m/%Y %H:%i');
ALTER TABLE olist_orders
DROP COLUMN order_purchase_timestamp,
DROP COLUMN order_delivered_customer_date,
DROP COLUMN order_estimated_delivery_date;
ALTER TABLE olist_orders
CHANGE COLUMN order_purchase_dt order_purchase_timestamp DATETIME,
CHANGE COLUMN order_delivered_dt order_delivered_customer_date DATETIME,
CHANGE COLUMN order_estimated_dt order_estimated_delivery_date DATETIME;
update olist_orders
set order_delivered_customer_date = NULL 
where order_delivered_customer_date < order_purchase_timestamp;
-- 3
update olist_order_items
set price = NULL WHERE PRICE <= 0;
UPDATE olist_order_items
set freight_value = null where freight_value <= 0;
-- 4
update olist_customers
SET 
    customer_unique_id = NULLIF(TRIM(customer_unique_id), ''),
    customer_city = NULLIF(TRIM(customer_city), ''),
    customer_state = NULLIF(TRIM(customer_state), '');
UPDATE olist_orders
SET order_status = NULLIF(TRIM(order_status), '');
UPDATE olist_reviews
SET 
	review_score = NULLIF(TRIM(review_score), ''),
	review_id = NULLIF(TRIM(review_id), '');
UPDATE olist_geolocation
SET 
    geolocation_city = NULLIF(TRIM(geolocation_city), ''),
	geolocation_lat = NULLIF(TRIM(geolocation_lat), ''),
    geolocation_lng = NULLIF(TRIM(geolocation_lng), ''),
    geolocation_state = NULLIF(TRIM(geolocation_state), '');
-- 5
select * from olist_order_items ;
DELETE FROM olist_order_items
WHERE (order_id, order_item_id) IN (
    SELECT order_id, order_item_id
    FROM (
        SELECT order_id, order_item_id
        FROM olist_order_items
        GROUP BY order_id, order_item_id
        HAVING COUNT(*) > 1
    ) AS dups
);
-- 6
DELETE FROM olist_order_items
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);
-- 7
SELECT COUNT(*),review_score FROM olist_reviews group by review_score;
delete from olist_reviews
where review_score = " " or NULL;
-- 8
SELECT COUNT(*),order_status FROM olist_orders group by order_status;
delete from olist_orders
where order_status = "CANCELED";
-- 9
CREATE TABLE customer_lifetime AS
SELECT 
    o.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_spent
FROM olist_orders o
JOIN olist_order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id;

-- 10
DELETE FROM olist_reviews
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);



