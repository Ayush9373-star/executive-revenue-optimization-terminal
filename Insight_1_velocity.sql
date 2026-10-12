USE instacart_analytics;

-- Step 1: Gather all the users and their shopping timelines.
WITH UserOrderTimelines AS (
    SELECT 
        user_id,
        order_number,
        days_since_prior_order
    FROM orders
    -- Filter out the first order: new accounts have no previous wait time.
    WHERE days_since_prior_order != -1 
)

-- Step 2: Find the average days between purchases for each milestone.
SELECT 
    order_number AS order_sequence_position,
    COUNT(user_id) AS total_orders_analyzed,
    ROUND(AVG(days_since_prior_order), 1) AS avg_days_since_last_purchase
FROM UserOrderTimelines
-- Limit the scan to the first 10 orders: this isolates early habit changes.
WHERE order_number <= 10 
GROUP BY order_number
ORDER BY order_number ASC;
