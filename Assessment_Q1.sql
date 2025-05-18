-- Assessment_Q1.sql
-- Question 1: High-Value Customers with both Savings and Investment Plans

SELECT
    u.id AS owner_id,
    u.name,
    COALESCE(s.savings_count, 0) AS savings_count,
    COALESCE(p.investment_count, 0) AS investment_count,
    COALESCE(s.savings_total, 0) + COALESCE(p.investment_total, 0) AS total_deposits
FROM
    users_customuser u
    LEFT JOIN (
        SELECT
            owner_id,
            COUNT(*) AS savings_count,
            SUM(amount) AS savings_total
        FROM savings_savingsaccount
        WHERE transaction_status = 'successful' -- Adjust if needed
        GROUP BY owner_id
    ) s ON u.id = s.owner_id
    LEFT JOIN (
        SELECT
            owner_id,
            COUNT(*) AS investment_count,
            SUM(amount) AS investment_total
        FROM plans_plan
        WHERE status_id = 1 -- Adjust if needed
        GROUP BY owner_id
    ) p ON u.id = p.owner_id
WHERE
    s.savings_count >= 1
    AND p.investment_count >= 1
ORDER BY
    total_deposits DESC;
    
    
-- Approach:
-- To identify customers with both a funded savings and a funded investment plan, 
-- I used subqueries to aggregate savings and investment counts and totals per user. 
-- Only users with at least one of each are included. The results are sorted by total deposits to highlight high-value customers.

-- Insight:
-- This query surfaces customers who are engaged with both savings and investment products, 
-- making them prime candidates for cross-selling and premium services. 
-- The top customer in the output has 2 savings and 28 investment plans, with a total deposit of 203,098,950, indicating significant engagement and value.

-- Challenges:
-- The main challenge was ensuring the correct identification of "funded" status in both tables. 
-- I used transaction_status = 'successful' and status_id = 1 as proxies for funded status, but these should be adjusted if your business logic differs.