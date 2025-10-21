import pandas as pd
from sqlalchemy import create_engine
from google.cloud import bigquery
from google.oauth2 import service_account

# --- Config ---
PG_CONN = "postgresql+psycopg2://postgres:postgres@localhost:5432/scheduler_db"
BQ_PROJECT = "emply-data-project"
BQ_DATASET = "emply_dw"
KEY_PATH = "/Users/miransalim/Emply_Data_Project/dbt_bigquery_key.json"
TABLES = ["postings_raw", "applications_raw"]

# --- Setup clients ---
print("🔗 Verbinden met PostgreSQL...")
pg_engine = create_engine(PG_CONN)
print("🔗 Verbinden met BigQuery...")
bq_client = bigquery.Client.from_service_account_json(KEY_PATH)

# --- Upload per tabel ---
for table in TABLES:
    print(f"\n⬆️  Bezig met upload van {table}...")

    # Data ophalen uit PostgreSQL
    df = pd.read_sql(f"SELECT * FROM {table}", pg_engine)
    print(f"📦 {len(df)} rijen opgehaald uit PostgreSQL.")

    # Upload naar BigQuery
    table_id = f"{BQ_PROJECT}.{BQ_DATASET}.{table}"
    job = bq_client.load_table_from_dataframe(df, table_id)
    job.result()

    print(f"✅ {table} succesvol geladen naar BigQuery ({BQ_DATASET})")

print("\n🎉 Alle tabellen zijn gesynchroniseerd met BigQuery!")
