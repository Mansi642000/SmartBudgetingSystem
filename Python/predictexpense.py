
import pymysql
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
from sklearn.linear_model import LinearRegression
import calendar
import os

# DB Setup
engine = create_engine("mysql+pymysql://root:Mansi%40642000@localhost/smart_grocery")
user_id = 5

# Step 1: Expense Data
df = pd.read_sql(f"SELECT date, price FROM expense WHERE user_id = {user_id}", engine)
df['date'] = pd.to_datetime(df['date'])
df['month'] = df['date'].dt.to_period('M').astype(str)
monthly_expense = df.groupby('month')['price'].sum().reset_index().rename(columns={'price': 'expense'})

# Step 2: Budget Data
budget_df = pd.read_sql(f"SELECT month, year, amount FROM budget WHERE user_id = {user_id}", engine)
budget_df['month_num'] = budget_df['month'].apply(lambda x: list(calendar.month_name).index(x))
budget_df['month'] = budget_df['year'].astype(str) + '-' + budget_df['month_num'].astype(str).str.zfill(2)
budget_df = budget_df[['month', 'amount']].rename(columns={'amount': 'budget'})

# Step 3: Merge and Prepare Data
merged = pd.merge(monthly_expense, budget_df, on='month', how='left')
merged['month_num'] = pd.to_datetime(merged['month']).dt.month

# Step 4: Model Training
X = merged[['month_num']]
y = merged['expense']
model = LinearRegression()
model.fit(X, y)

# Step 5: Predict Next Month
next_month_num = merged['month_num'].max() + 1
predicted_expense = model.predict([[next_month_num]])[0]
next_month_name = calendar.month_name[next_month_num]
next_month_str = f"2025-{str(next_month_num).zfill(2)}"

# Step 6: Add Predicted Row using pd.concat (pandas 2.x safe)
predicted_row = pd.DataFrame([{
    'month': next_month_str,
    'expense': predicted_expense,
    'budget': np.nan,
    'month_num': next_month_num
}])

merged = pd.concat([merged, predicted_row], ignore_index=True)


# Step 7: Chart Drawing
expense_colors = ['red' if exp > bud else 'lightblue' for exp, bud in zip(merged['expense'], merged['budget'])]
expense_colors[-1] = 'purple'  # Color for predicted bar
budget_colors = ['lightgreen'] * len(merged)

x = np.arange(len(merged['month']))
width = 0.35

plt.figure(figsize=(10, 6))
plt.bar(x - width/2, merged['expense'], width, label='Expense', color=expense_colors)
plt.bar(x + width/2, merged['budget'], width, label='Budget', color=budget_colors)

plt.xlabel('Month')
plt.ylabel('Amount (₹)')
plt.title('Monthly Expense vs Budget (with Predicted Expense)')
plt.xticks(x, merged['month'], rotation=45)
plt.legend()
plt.grid(True, axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()

# Step 8: Save Chart
output_path = r"C:\Users\hp\eclipse-workspace\Smart_Budgeting_System\src\main\webapp\images\prediction.png"
plt.savefig(output_path)
plt.close()

print(f"{next_month_name},{predicted_expense:.2f}")
