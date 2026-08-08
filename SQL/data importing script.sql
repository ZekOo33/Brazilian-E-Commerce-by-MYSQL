SHOW VARIABLES LIKE 'secure_file_priv';
SET GLOBAL local_infile = 1;


-- olist_orders
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE olist_orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id,
 customer_id,
 order_status,
 @purchase_ts,            -- will store into string column below
 @approved_at,            -- skip
 @carrier_dt,             -- skip
 @delivered_dt,           -- will store into string column below
 @estimated_dt)           -- will store into string column below
SET
  order_purchase_timestamp      = NULLIF(TRIM(@purchase_ts),''),
  order_delivered_customer_date = NULLIF(TRIM(@delivered_dt),''),
  order_estimated_delivery_date = NULLIF(TRIM(@estimated_dt),'');

-- olist_order_items

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE olist_order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(order_id,
 order_item_id,
 product_id,
 @seller_id,              -- skip
 @shipping_limit_date,    -- skip
 price,
 freight_value);


-- olist_customers

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE olist_customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(customer_id,
 customer_unique_id,
 @zip,
 @city,
 @state)
SET
  customer_zip_code_prefix = NULLIF(TRIM(@zip),''),
  customer_city            = NULLIF(TRIM(@city),''),
  customer_state           = NULLIF(TRIM(@state),'');

-- olist_reviews

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE olist_reviews
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(review_id,
 order_id,
 review_score,
 @title,                 -- skip
 @message,               -- skip
 review_creation_date,   -- store raw string date as-is
 @ans_ts);               -- skip


-- olist_geolocation

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(geolocation_zip_code_prefix,
 geolocation_lat,
 geolocation_lng,
 geolocation_city,
 geolocation_state);