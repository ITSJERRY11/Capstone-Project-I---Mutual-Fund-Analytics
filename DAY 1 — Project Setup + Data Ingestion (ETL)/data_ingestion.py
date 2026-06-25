import pandas as pd
import os

# Define the folder where your CSVs are stored (leave as '' if in the same folder as the script)
data_folder = './Datasets/' 

# List all 10 CSV filenames here
csv_files = [
    '01_fund_master.csv',
    '02_nav_history.csv',
    '03_aum_by_fund_house.csv',
    '04_monthly_sip_inflows.csv',
    '05_category_inflows.csv',
    '06_industry_folio_count.csv',
    '07_scheme_performance.csv',
    '08_investor_transactions.csv',
    '09_portfolio_holdings.csv',
    '10_benchmark_indices.csv'
]


# Create an empty dictionary to hold our DataFrames
datasets = {}

print("--- Loading Datasets ---")
for file in csv_files:
    file_path = os.path.join(data_folder, file)
    try:
        # Remove '.csv' from the filename to use as the dictionary key
        dataset_name = file.replace('.csv', '')
        
        # Load the CSV into pandas
        datasets[dataset_name] = pd.read_csv(file_path)
        print(f"Successfully loaded: {file}")
    except FileNotFoundError:
        print(f"Error: {file} not found at {file_path}")

print("\n--- Dataset Summaries ---")
for name, df in datasets.items():
    print(f"\nDataset: {name}")
    print(f"Shape: {df.shape}")
    print("Data Types:")
    print(df.dtypes)
    print("First 5 rows:")
    print(df.head())
    print("-" * 40)