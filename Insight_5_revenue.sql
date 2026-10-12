USE instacart_analytics;

-- Step 1: Find the high value VIP users who have made 30 or more lifetime orders.
WITH VIPUserRegistry AS (
    SELECT 
        user_id
    FROM orders
    GROUP BY user_id
    HAVING MAX(order_number) >= 30
),

-- Step 2: Link the orders ledger to the products table to match names with logs.
TransactionProductMap AS (
    SELECT 
        o.user_id,
        o.order_id,
        p.product_name
    FROM orders o
    -- Cross join rule: map the product catalogs to the active sales records.
    INNER JOIN products p ON o.order_id = p.product_id 
)

-- Step 3: Find the top 5 highest volume items bought by the VIP segment.
SELECT 
    t.product_name AS vip_favorite_product,
    COUNT(t.order_id) AS total_vip_purchases
FROM TransactionProductMap t
-- Filter rule: ignore casual users and only look at transactions from the VIP registry.
INNER JOIN VIPUserRegistry v ON t.user_id = v.user_id
GROUP BY t.product_name
ORDER BY total_vip_purchases DESC
LIMIT 5;
