create schema  retailco_olist;
-- Table 1: olist_customers
CREATE TABLE olist_customers (
    customer_id VARCHAR(100) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state CHAR(3)
);
-- Table 2: olist_orders
CREATE TABLE olist_orders (
    order_id VARCHAR(100) PRIMARY KEY,
    customer_id VARCHAR(100),
    order_status VARCHAR(50),
    order_purchase_timestamp VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);
-- Table 3: olist_order_items
CREATE TABLE olist_order_items (
    order_id VARCHAR(100),
    order_item_id INT,
    product_id VARCHAR(100),
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id)
);
-- Table 4: olist_reviews
CREATE TABLE olist_reviews (
    review_id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100),
    review_score INT,
    review_creation_date varchar(50)
);

-- Table 5: olist_geolocation
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10,6),
    geolocation_lng DECIMAL(10,6),
    geolocation_city VARCHAR(50),
    geolocation_state CHAR(2)
);

