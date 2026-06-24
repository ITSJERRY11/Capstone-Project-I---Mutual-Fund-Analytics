# live_nav_fetch.py
import requests
import pandas as pd
import os

# Ensure the raw data directory exists
os.makedirs('data/raw', exist_ok=True)

def fetch_and_save_nav(scheme_code, filename):
    url = f"https://api.mfapi.in/mf/{scheme_code}"
    response = requests.get(url)
    
    if response.status_code == 200:
        data = response.json()
        # Extract the 'data' portion which contains the NAV history
        nav_data = data.get('data', [])
        if nav_data:
            df = pd.DataFrame(nav_data)
            filepath = f"data/raw/{filename}.csv"
            df.to_csv(filepath, index=False)
            print(f"Successfully saved {filename} NAV data.")
        else:
            print(f"No NAV data found for scheme {scheme_code}.")
    else:
        print(f"Failed to fetch data for scheme {scheme_code}. Status: {response.status_code}")

if __name__ == "__main__":
    # Fetch HDFC Top 100 Direct
    fetch_and_save_nav(125497, 'hdfc_top_100_125497')
    
    # Fetch 5 Key Schemes
    key_schemes = {
        'sbi_bluechip': 119551,
        'icici_bluechip': 120503,
        'nippon_large_cap': 118632,
        'axis_bluechip': 119092,
        'kotak_bluechip': 120841
    }
    
    for name, code in key_schemes.items():
        fetch_and_save_nav(code, name)