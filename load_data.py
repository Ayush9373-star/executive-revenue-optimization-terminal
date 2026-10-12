import pandas as pd
from sqlalchemy import create_engine

# 1. Connecting to database.
engine = create_engine('mysql+mysqlconnector://root:ayush@localhost/Instacart_Analytics')

# 2. Loading  the small products file in one shot.
print("Loading products...")
pd.read_csv("products.csv").to_sql('products', con=engine, if_exists='append', index=False)

# 3. Loading the large orders file in easy chunks.
print("Loading orders...")
for chunk in pd.read_csv("orders.csv", chunksize=500000):
    chunk['days_since_prior_order'] = chunk['days_since_prior_order'].fillna(-1)
    chunk.to_sql('orders', con=engine, if_exists='append', index=False)
    print("Pushed a chunk!")

print(" All data is inside MySQL!")
