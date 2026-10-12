USE instacart_analytics;

-- Step 1: Find the absolute maximum number of lifetime orders for each user.
WITH UserLifetimeSpends AS (
    SELECT 
        user_id,
        MAX(order_number) AS total_lifetime_orders
    FROM orders
    GROUP BY user_id
),

-- Step 2: Separate users into different loyalty groups based on their order totals.
UserTiers AS (
    SELECT 
        user_id,
        total_lifetime_orders,
        CASE 
            -- VIP status is given to anyone with 30 or more orders.
            WHEN total_lifetime_orders >= 30 THEN 'VIP Power Spender'
            -- All other accounts are labeled as casual shoppers.
            ELSE 'Casual Shopper'
        END AS customer_business_tier
    FROM UserLifetimeSpends
)

-- Step 3: Count total users and find the average order numbers for each group.
SELECT 
    customer_business_tier,
    COUNT(user_id) AS total_users_in_tier,
    ROUND(AVG(total_lifetime_orders), 1) AS avg_lifetime_orders_placed
FROM UserTiers
GROUP BY customer_business_tier;
