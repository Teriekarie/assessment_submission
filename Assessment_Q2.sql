-- Assessment_Q2.sql
-- Question 2: Analyze transaction frequency per customer and categorize

WITH customer_activity AS (
    SELECT 
        p.owner_id,
        COUNT(s.id) AS total_transactions,
        PERIOD_DIFF(
            DATE_FORMAT(CURDATE(), '%Y%m'),
            DATE_FORMAT(MIN(s.created_on), '%Y%m')
        ) + 1 AS months_active
    FROM 
        savings_savingsaccount s
    JOIN 
        plans_plan p ON s.plan_id = p.id
    GROUP BY 
        p.owner_id
),
categorized_customers AS (
    SELECT 
        c.owner_id,
        ROUND(c.total_transactions / c.months_active, 1) AS avg_transactions_per_month,
        CASE 
            WHEN (c.total_transactions / c.months_active) >= 10 THEN 'High Frequency'
            WHEN (c.total_transactions / c.months_active) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        customer_activity c
)

SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    categorized_customers
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');


-- Approach:
-- I calculated each customer’s average transactions per month by dividing their total transactions by the number of months since their first transaction. 
-- This method ensures that periods of inactivity are included, providing a realistic measure of transaction frequency. Customers are then categorized as High (≥10/month), Medium (3–9/month), or Low (≤2/month) frequency.

-- Insight:
-- This segmentation reveals that 107 customers are highly engaged (averaging 36.7 transactions/month), 76 are moderately engaged, and 690 transact infrequently. 
-- This allows targeted marketing and engagement strategies for each segment.

-- Challenges:
-- The main challenge was ensuring that the frequency calculation included inactive months, not just months with activity, to avoid overestimating engagement.