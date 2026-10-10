USE instacart_analytics;

-- Step 1: Create a clean summary table of users and their timelines
WITH UserOrderTimelines AS (
    SELECT 
        user_id,
        order_number,
        days_since_prior_order
    FROM orders
    -- Exclude the very first order because there is no prior waiting time (-1)
    WHERE days_since_prior_order != -1 
)

-- Step 2: Calculate the average time gap for each order step in a user's lifecycle
SELECT 
    order_number AS order_sequence_position,
    COUNT(user_id) AS total_orders_analyzed,
    ROUND(AVG(days_since_prior_order), 1) AS avg_days_since_last_purchase
FROM UserOrderTimelines
-- Look at the first 10 sequential orders to spot the pattern cleanly
WHERE order_number <= 10 
GROUP BY order_number
ORDER BY order_number ASC;
