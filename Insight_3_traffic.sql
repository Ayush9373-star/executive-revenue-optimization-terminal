USE instacart_analytics;

-- Block 1: Calculate total orders for each hour and find its daily traffic share percentage
SELECT 
    order_hour_of_day AS shopping_hour_24h,
    COUNT(order_id) AS total_orders_placed,
    -- Advanced Step: Calculate what % of ALL weekly transactions hit this specific hour
    ROUND((COUNT(order_id) / 3421083.0) * 100, 2) AS traffic_share_percentage
FROM orders
GROUP BY order_hour_of_day
ORDER BY total_orders_placed DESC
LIMIT 5; -- Show us the top 5 absolute peak rush hours

