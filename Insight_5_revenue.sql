USE instacart_analytics;

-- Block 1: Isolate our elite VIP users who have placed 30 or more lifetime orders
WITH VIPUserRegistry AS (
    SELECT 
        user_id
    FROM orders
    GROUP BY user_id
    HAVING MAX(order_number) >= 30
),

-- Block 2: Join the orders and products tables together to see WHAT items were purchased
TransactionProductMap AS (
    SELECT 
        o.user_id,
        o.order_id,
        p.product_name
    FROM orders o
    -- Match the item names to the order logs
    INNER JOIN products p ON o.order_id = p.product_id -- Simple relational map link
)

-- Block 3: Extract the absolute top 5 products favored by our elite VIP segment
SELECT 
    t.product_name AS vip_favorite_product,
    COUNT(t.order_id) AS total_vip_purchases
FROM TransactionProductMap t
-- Only look at the transaction rows belonging to our VIP users
INNER JOIN VIPUserRegistry v ON t.user_id = v.user_id
GROUP BY t.product_name
ORDER BY total_vip_purchases DESC
LIMIT 5;
