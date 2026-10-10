USE instacart_analytics;

-- Block 1: Find the maximum number of lifetime orders placed by each unique user
WITH UserLifetimeSpends AS (
    SELECT 
        user_id,
        MAX(order_number) AS total_lifetime_orders
    FROM orders
    GROUP BY user_id
),

-- Block 2: Automatically tag each user based on their loyalty score
UserTiers AS (
    SELECT 
        user_id,
        total_lifetime_orders,
        CASE 
            -- If a user has ordered 30 or more times, tag them as an elite VIP
            WHEN total_lifetime_orders >= 30 THEN 'VIP Power Spender'
            -- Otherwise, tag them as a regular casual shopper
            ELSE 'Casual Shopper'
        END AS customer_business_tier
    FROM UserLifetimeSpends
)

-- Block 3: Count the users in each group and calculate their average habits
SELECT 
    customer_business_tier,
    COUNT(user_id) AS total_users_in_tier,
    ROUND(AVG(total_lifetime_orders), 1) AS avg_lifetime_orders_placed
FROM UserTiers
GROUP BY customer_business_tier;
