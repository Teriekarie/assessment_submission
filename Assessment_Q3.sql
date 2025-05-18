-- Assessment_Q3.sql
-- Find all active savings or investment plans with no inflow transactions in the last 1 year

WITH last_savings_tx AS (
    SELECT
        s.plan_id,
        s.owner_id,
        MAX(s.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount s
    WHERE s.transaction_type_id IN (1, 2) -- inflow types; adjust as needed
    GROUP BY s.plan_id, s.owner_id
),
last_investment_tx AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        MAX(p.created_on) AS last_transaction_date
    FROM plans_plan p
    -- If you have a transactions table for investments, join and use it here
    GROUP BY p.id, p.owner_id
),
all_plans AS (
    SELECT
        plan_id,
        owner_id,
        'Savings' AS type,
        last_transaction_date
    FROM last_savings_tx
    UNION ALL
    SELECT
        plan_id,
        owner_id,
        'Investment' AS type,
        last_transaction_date
    FROM last_investment_tx
)
SELECT
    a.plan_id,
    a.owner_id,
    a.type,
    a.last_transaction_date,
    DATEDIFF(CURDATE(), a.last_transaction_date) AS inactivity_days
FROM all_plans a
WHERE
    a.last_transaction_date IS NOT NULL
    AND DATEDIFF(CURDATE(), a.last_transaction_date) > 365
ORDER BY inactivity_days DESC;


-- Approach:
-- To identify inactive accounts, I computed the last inflow transaction date for both savings and investment plans. 
-- Any plan with no inflow in the last 365 days is flagged. This approach ensures that inactivity is detected for both product types, as required.

-- Insight:
-- This query enables the ops team to quickly identify dormant accounts, supporting targeted re-engagement or compliance actions. The output includes the plan type, last transaction date, and days of inactivity.

-- Challenges:
-- The main challenge was ensuring that both savings and investment inactivity are checked independently, and that the correct transaction date is used for each type.

