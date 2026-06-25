# Data Dictionary: Bluestock Mutual Fund Database

## `dim_fund`
| Column | Data Type | Description | Source |
| :--- | :--- | :--- | :--- |
| `fund_id` | INT (PK) | Surrogate key for the fund | Generated |
| `amfi_code` | VARCHAR | Unique identifier provided by AMFI | `nav_history.csv` |
| `fund_name` | VARCHAR | Official name of the mutual fund | `nav_history.csv` |
| `category` | VARCHAR | Equity, Debt, Hybrid, etc. | `scheme_performance.csv` |

## `fact_transactions`
| Column | Data Type | Description | Source |
| :--- | :--- | :--- | :--- |
| `txn_id` | INT (PK) | Unique transaction identifier | Generated |
| `fund_id` | INT (FK) | Foreign key to `dim_fund` | `investor_transactions.csv` |
| `investor_id` | INT (FK) | Foreign key to `dim_investor` | `investor_transactions.csv` |
| `transaction_type` | VARCHAR | Standardised to SIP, Lumpsum, or Redemption | `investor_transactions.csv` |
| `amount` | DECIMAL | Monetary value of the transaction (>0) | `investor_transactions.csv` |