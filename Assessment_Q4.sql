-- Assessment_Q4.sql
-- Question 4: Estimate Customer Lifetime Value (CLV)

SELECT
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    -- CLV formula: (transactions / tenure) * 12 * avg_profit_per_transaction
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) 
        * 12 
        * (0.001 * SUM(s.confirmed_amount) / COUNT(s.id) / 100), 
        2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    plans_plan p ON p.owner_id = u.id
JOIN 
    savings_savingsaccount s ON s.plan_id = p.id
GROUP BY 
    u.id, u.name, u.date_joined
ORDER BY 
    estimated_clv DESC;
    
    
-- Approach:  
-- For each customer, I calculated account tenure in months since signup, total transactions, and estimated CLV using the formula:  
-- CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction  
-- where avg_profit_per_transaction is 0.1% of the average confirmed transaction value (converted to naira).

-- Insight: 
-- This allows marketing to identify high-value customers based on both longevity and transaction activity, 
-- supporting targeted retention and upsell strategies. The CLV is an annualized profit estimate, not just a sum of deposits.

-- Challenges:  
-- The main challenge was handling customers with zero tenure (to avoid division by zero) and 
-- ensuring the correct transaction value column was used. I used `confirmed_amount` and divided by 100 to convert from kobo to naira.
