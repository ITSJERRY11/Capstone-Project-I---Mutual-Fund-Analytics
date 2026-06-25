-- schema.sql

CREATE TABLE dim_fund (
    fund_id INTEGER PRIMARY KEY AUTOINCREMENT,
    amfi_code VARCHAR(50) UNIQUE NOT NULL,
    fund_name VARCHAR(255) NOT NULL,
    category VARCHAR(100)
);

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY, -- e.g., 20260625
    full_date DATE NOT NULL,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    is_weekend BOOLEAN
);

CREATE TABLE dim_investor (
    investor_id INTEGER PRIMARY KEY,
    state VARCHAR(100),
    kyc_status VARCHAR(50)
);

CREATE TABLE fact_nav (
    nav_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_id INTEGER,
    date_id INTEGER,
    nav_value DECIMAL(10, 4),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

CREATE TABLE fact_transactions (
    txn_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_id INTEGER,
    investor_id INTEGER,
    date_id INTEGER,
    transaction_type VARCHAR(50),
    amount DECIMAL(15, 2),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id),
    FOREIGN KEY (investor_id) REFERENCES dim_investor(investor_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

CREATE TABLE fact_performance (
    perf_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_id INTEGER,
    date_id INTEGER,
    return_1yr DECIMAL(5, 2),
    return_3yr DECIMAL(5, 2),
    return_5yr DECIMAL(5, 2),
    expense_ratio DECIMAL(5, 2),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

CREATE TABLE fact_aum (
    aum_id INTEGER PRIMARY KEY AUTOINCREMENT,
    fund_id INTEGER,
    date_id INTEGER,
    total_aum DECIMAL(20, 2),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);