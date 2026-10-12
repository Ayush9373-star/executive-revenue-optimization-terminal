USE instacart_analytics;

-- Step 1: Count the orders for each hour and find the traffic percentage.
SELECT 
    order_hour_of_day AS shopping_hour_24h,
    COUNT(order_id) AS total_orders_placed,
    -- Calculation: divide the hourly volume by the total 3.4 Million orders.
    ROUND((COUNT(order_id) / 3421083.0) * 100, 2) AS traffic_share_percentage
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders_placed DESC
LIMIT 5; -- Limit the list to the top 5 absolute busiest rush hours.

