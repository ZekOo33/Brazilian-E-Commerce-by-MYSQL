ALTER TABLE olist_orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES olist_customers(customer_id);

ALTER TABLE olist_order_items
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);

ALTER TABLE olist_reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);

SELECT order_id, customer_id
FROM olist_orders
WHERE customer_id NOT IN (SELECT customer_id FROM olist_customers);
SELECT count(*)
FROM olist_order_items
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);
SELECT order_id
FROM olist_reviews
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);

DELETE FROM olist_orders
WHERE customer_id NOT IN (SELECT customer_id FROM olist_customers);

DELETE FROM olist_order_items
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);

DELETE FROM olist_reviews
WHERE order_id NOT IN (SELECT order_id FROM olist_orders);

SELECT 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'retailco_olist'
AND REFERENCED_TABLE_NAME IS NOT NULL;

