# assessment_submission
SQL-based data analysis assessment for Cowrywise. Includes business-driven solutions for segmentation, CLV estimation, account inactivity, and customer behavior analysis.

# Conclusion
Throughout this assessment, I demonstrated a comprehensive and methodical approach to SQL-based data analytics, from data extraction and preparation to advanced querying and business insight generation.

# Data Preparation & Extraction
Table Extraction: I began by parsing and analyzing raw SQL dump files, using custom Python scripts to accurately count and validate row counts for large tables. This ensured data integrity and readiness for analysis.
Dummy Data Generation: Recognizing the need for referential integrity, I programmatically generated and inserted dummy records (e.g., for the users_tier table and withdrawals_withdrawalintent) to match foreign key constraints, using MySQL stored procedures for efficiency and scalability.

# Business-Focused SQL Solutions
For each assessment question, I crafted optimized, well-documented SQL queries that not only deliver accurate results but also provide actionable business insights:

High-Value Customers with Multiple Products:
Identified customers with both funded savings and investment plans, sorted by total deposits. This supports cross-selling and premium targeting strategies.

Transaction Frequency Analysis:
Segmented customers into high, medium, and low-frequency groups based on average monthly transactions, enabling tailored engagement and retention campaigns.

Account Inactivity Alert:
Flagged accounts with no inflow transactions for over a year, empowering operations to proactively address dormant accounts and reduce churn.

Customer Lifetime Value (CLV) Estimation:
Calculated annualized CLV for each customer, factoring in tenure and transaction volume, to help marketing prioritize high-value relationships.

Technical Rigor & Best Practices
Efficient Query Design: Used CTEs, aggregation, and conditional logic to ensure queries are both performant and readable, even on large datasets.
Documentation: Each SQL file includes clear comments and logical structure, making the codebase easy to maintain and extend.

## (Optional) Dashboard Summary

If visualized in a dashboard, here’s what I’d showcase:

- **Bar Chart**: Top customers by CLV (Q4)
- **Pie Chart**: Distribution of transaction frequency segments (Q2)
- **Table**: Inactive accounts flagged by type (Q3)
- **Leaderboard View**: High-value cross-sell leads (Q1)

This would support quick marketing, ops, and finance decisions using actionable insights.

---

## Final Notes

- All solutions are original and tested on live tables loaded from the MySQL dump.
- Query logic emphasizes clarity, performance, and business value.
- I approached this assessment as I would a real analytics request: validate assumptions, structure logic, explain outcomes.




