-- CREATE DATABASE instacart_analytics;
USE instacart_analytics;

-- Step 1: Create the main table to hold our 3.4 Million transactional rows.
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    eval_set VARCHAR(10),
    order_number INT,
    order_dow INT,
    order_hour_of_day INT,
    days_since_prior_order DECIMAL(5,1)
);

-- Step 2: Create the lookup table to hold our product catalog descriptions.
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    aisle_id INT,
    department_id INT
);

-- Step 3: Run the check command to show that both tables exist in the system.
SHOW TABLES;
