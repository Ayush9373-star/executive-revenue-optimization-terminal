USE instacart_analytics;

-- Step 1: Find the normal shopping gap and the longest gap for every customer.
WITH NormalHabits AS (
    SELECT 
        user_id,
        AVG(days_since_prior_order) AS regular_days_between_orders,
        MAX(days_since_prior_order) AS longest_break_taken
    FROM orders
    -- Filter out the first order: new accounts have no previous wait time.
    WHERE days_since_prior_order != -1 
    GROUP BY user_id
)

-- Step 2: Find customers whose longest gap is 3 times bigger than their normal gap.
SELECT 
    COUNT(user_id) AS total_ghosting_customers,
    ROUND(AVG(regular_days_between_orders), 1) AS standard_waiting_days,
    ROUND(AVG(longest_break_taken), 1) AS broken_habit_waiting_days
FROM NormalHabits
-- Filter context: isolate users who completely broke their normal shopping frequency loop.
WHERE longest_break_taken > (regular_days_between_orders * 3);
