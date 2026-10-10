USE instacart_analytics;

-- Block 1: Write down the regular habit and the longest break for every person
WITH NormalHabits AS (
    SELECT 
        user_id,
        AVG(days_since_prior_order) AS regular_days_between_orders,
        MAX(days_since_prior_order) AS longest_break_taken
    FROM orders
    WHERE days_since_prior_order != -1 -- Ignore their very first day
    GROUP BY user_id
)

-- Block 2: Count how many people took a break that was 3 times longer than normal
SELECT 
    COUNT(user_id) AS total_ghosting_customers,
    ROUND(AVG(regular_days_between_orders), 1) AS standard_waiting_days,
    ROUND(AVG(longest_break_taken), 1) AS broken_habit_waiting_days
FROM NormalHabits
WHERE longest_break_taken > (regular_days_between_orders * 3);
