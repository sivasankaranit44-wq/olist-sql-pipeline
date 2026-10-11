from sqlalchemy import create_engine, text

SERVER = "localhost\\SQLEXPRESS01"
DATABASE = "olistdb"

engine = create_engine(
    f"mssql+pyodbc://@{SERVER}/{DATABASE}"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&trusted_connection=yes"
    "&TrustServerCertificate=yes"
)

with engine.connect() as conn:
    print(conn.execute(text("SELECT @@VERSION")).scalar())