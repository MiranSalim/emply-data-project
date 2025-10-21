import pandas as pd
from sqlalchemy import create_engine
from google.cloud import bigquery

# --- Config ---
PG_CONN = "postgresql+psycopg2://postgres:<JOUW_WACHTWOORD>@emply-scheduler-db.ctgcuyccsify.eu-north-1.rds.amazonaws.com:5432/scheduler_db"
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

    # ✅ UUID- en JSON-kolommen converteren naar string
    for col in df.columns:
        if df[col].dtype == "object":
            # controleer op UUID-achtige waarden
            if df[col].apply(lambda x: isinstance(x, (bytes, bytearray)) or str(type(x)).endswith("UUID'>")).any():
                df[col] = df[col].astype(str)
        elif "uuid" in str(df[col].dtype).lower():
            df[col] = df[col].astype(str)

    # ✅ JSON-achtige kolommen veilig converteren
    df = df.applymap(lambda x: str(x) if isinstance(x, (dict, list)) else x)

    # Upload naar BigQuery
    table_id = f"{BQ_PROJECT}.{BQ_DATASET}.{table}"
    job_config = bigquery.LoadJobConfig(write_disposition="WRITE_TRUNCATE")  # overschrijven bij nieuwe upload
    job = bq_client.load_table_from_dataframe(df, table_id, job_config=job_config)
    job.result()

    print(f"✅ {table} succesvol geladen naar BigQuery ({BQ_DATASET})")

print("\n🎉 Alle tabellen zijn gesynchroniseerd met BigQuery!")
