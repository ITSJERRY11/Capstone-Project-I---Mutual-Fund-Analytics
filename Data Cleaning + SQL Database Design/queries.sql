-- 1. Top 5 funds by AUM (Assuming latest date)
SELECT df.fund_name, fa.total_aum
FROM fact_aum fa
JOIN dim_fund df ON fa.fund_id = df.fund_id
ORDER BY fa.total_aum DESC
LIMIT 5;

-- 2. Average NAV per month
SELECT dd.year, dd.month, AVG(fn.nav_value) as avg_nav
FROM fact_nav fn
JOIN dim_date dd ON fn.date_id = dd.date_id
GROUP BY dd.year, dd.month
ORDER BY dd.year, dd.month;

-- 3. SIP YoY Growth (Total SIP amount per year)
SELECT dd.year, SUM(ft.amount) as total_sip_volume
FROM fact_transactions ft
JOIN dim_date dd ON ft.date_id = dd.date_id
WHERE ft.transaction_type = 'SIP'
GROUP BY dd.year
ORDER BY dd.year;

-- 4. Transactions by state
SELECT di.state, COUNT(ft.txn_id) as total_transactions, SUM(ft.amount) as total_volume
FROM fact_transactions ft
JOIN dim_investor di ON ft.investor_id = di.investor_id
GROUP BY di.state
ORDER BY total_volume DESC;

-- 5. Funds with expense_ratio < 1%
SELECT df.fund_name, fp.expense_ratio
FROM fact_performance fp
JOIN dim_fund df ON fp.fund_id = df.fund_id
WHERE fp.expense_ratio < 1.0;

-- 6. [Custom] Top 3 Funds with Highest Redemption Volume
SELECT df.fund_name, SUM(ft.amount) as total_redemptions
FROM fact_transactions ft
JOIN dim_fund df ON ft.fund_id = df.fund_id
WHERE ft.transaction_type = 'Redemption'
GROUP BY df.fund_name
ORDER BY total_redemptions DESC
LIMIT 3;

-- 7. [Custom] Count of Transactions by KYC Status
SELECT di.kyc_status, COUNT(ft.txn_id) as txn_count
FROM fact_transactions ft
JOIN dim_investor di ON ft.investor_id = di.investor_id
GROUP BY di.kyc_status;

-- 8. [Custom] Best Performing Funds (3Yr Return)
SELECT df.fund_name, fp.return_3yr
FROM fact_performance fp
JOIN dim_fund df ON fp.fund_id = df.fund_id
ORDER BY fp.return_3yr DESC
LIMIT 5;

-- 9. [Custom] Monthly Inflow vs Outflow
SELECT dd.year, dd.month,
       SUM(CASE WHEN ft.transaction_type IN ('SIP', 'Lumpsum') THEN ft.amount ELSE 0 END) as total_inflow,
       SUM(CASE WHEN ft.transaction_type = 'Redemption' THEN ft.amount ELSE 0 END) as total_outflow
FROM fact_transactions ft
JOIN dim_date dd ON ft.date_id = dd.date_id
GROUP BY dd.year, dd.month;

-- 10. [Custom] Average Lumpsum Investment Size
SELECT df.category, AVG(ft.amount) as avg_lumpsum
FROM fact_transactions ft
JOIN dim_fund df ON ft.fund_id = df.fund_id
WHERE ft.transaction_type = 'Lumpsum'
GROUP BY df.category;