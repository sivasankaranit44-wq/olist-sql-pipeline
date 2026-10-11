import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

SERVER = "localhost\\SQLEXPRESS01"
DATABASE = "olistdb"

engine = create_engine(
    f"mssql+pyodbc://@{SERVER}/{DATABASE}"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&trusted_connection=yes"
    "&TrustServerCertificate=yes",
    fast_executemany=True
)

for f in sorted(Path("data").glob('*csv')):
    table = f.stem.replace("olist_", "").replace("_dataset", "")
    df= pd.read_csv(f)
    df.to_sql(table, engine, schema="bronze", if_exists="replace", index= False)
    print(f"{table}, {len(df)}")