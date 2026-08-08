SET SQL_SAFE_UPDATES = 0;
ALTER TABLE olist_orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES olist_customers(customer_id);

ALTER TABLE olist_order_items
ADD CONSTRAINT fk_items_orders
FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);
 
ALTER TABLE olist_reviews
ADD CONSTRAINT fk_reviews_orders
FOREIGN KEY (order_id) REFERENCES olist_orders(order_id);

SELECT r.order_id
FROM olist_reviews r
LEFT JOIN olist_orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

DELETE r
FROM olist_reviews r
LEFT JOIN olist_orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;