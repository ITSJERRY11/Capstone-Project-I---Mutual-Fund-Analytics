import pandas as pd
import os

data_folder = './Datasets/'

# Load required datasets
fund_master = pd.read_csv(os.path.join(data_folder, '01_fund_master.csv'))
nav_history = pd.read_csv(os.path.join(data_folder, '02_nav_history.csv'))

print("--- Fund Master Exploration ---")
# Adjust column names based on your actual CSV headers
print("\nUnique Fund Houses:", fund_master['fund_house'].nunique())
print("\nUnique Categories:", fund_master['category'].unique())
print("\nUnique Sub-Categories:", fund_master['sub_category'].unique())
print("\nUnique Risk Grades:", fund_master['risk_grade'].unique())

print("\n--- AMFI Code Validation ---")
master_codes = set(fund_master['scheme_code'].dropna())
nav_codes = set(nav_history['scheme_code'].dropna())

# Find codes in fund_master that do not exist in nav_history
missing_in_nav = master_codes - nav_codes
missing_count = len(missing_in_nav)

print(f"Total scheme codes in Fund Master: {len(master_codes)}")
print(f"Total scheme codes in NAV History: {len(nav_codes)}")

if missing_count == 0:
    print("Validation Passed: Every code in fund_master exists in nav_history.")
else:
    print(f"Validation Failed: {missing_count} codes from fund_master are missing in nav_history.")
    print("Sample missing codes:", list(missing_in_nav)[:5])