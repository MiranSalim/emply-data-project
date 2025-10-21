import os
import requests
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from .db import SessionLocal, Base, engine
from .models import Posting, Application

# Maak tabellen aan als ze nog niet bestaan
Base.metadata.create_all(bind=engine)

API_URL = os.getenv("SOURCE_API_URL")
API_KEY = os.getenv("SOURCE_API_KEY")


def fetch_postings(customer: str, media_id: str):
    """Haalt postings op voor een bepaalde klant en media_id."""
    url = f"{API_URL}/{customer}/postings/{media_id}"
    r = requests.get(url, headers={"x-api-key": API_KEY})
    r.raise_for_status()
    return r.json()


def fetch_applications(customer: str, start: datetime, end: datetime):
    """Haalt applications op binnen een datumbereik."""
    url = f"{API_URL}/{customer}/applications/find-by-date"
    params = {"from": start.isoformat(), "to": end.isoformat()}
    r = requests.get(url, headers={"x-api-key": API_KEY}, params=params)
    r.raise_for_status()
    return r.json()


def ingest_once(customer="acme"):
    """Voert één ingest-run uit: postings + applications ophalen en opslaan."""
    db: Session = SessionLocal()
    try:
        print(f"\n🚀 Start ingest-run voor customer: {customer}")

        # 1️⃣ Ophalen applications (bron voor geldige media/vacancy IDs)
        start = datetime.utcnow() - timedelta(days=90)
        end = datetime.utcnow()
        print("→ Ophalen applications om media_id's te bepalen...")
        apps = fetch_applications(customer, start, end)
        print(f"✅ {len(apps)} applications opgehaald")

        # Verzamel unieke vacancy_id's (die overeenkomen met postings.media_id)
        media_ids = list({a.get("vacancy_id") for a in apps if a.get("vacancy_id")})
        print(f"→ {len(media_ids)} unieke media_id's gevonden")

        # 2️⃣ Voor elke media_id postings ophalen
        total_postings = 0
        for m_id in media_ids:
            postings = fetch_postings(customer, m_id)
            for p in postings:
                db.add(
                    Posting(
                        job_id=p["job_id"],
                        vacancy_id=p["vacancy_id"],
                        customer=customer,
                        media_id=p["media_id"],
                        created_at=datetime.fromisoformat(p["created"]),
                        raw_data=p,
                    )
                )
                total_postings += 1
        db.commit()
        print(f"✅ {total_postings} postings opgeslagen")

        # 3️⃣ Applications opslaan
        total_apps = 0
        for a in apps:
            db.add(
                Application(
                    application_id=a["id"],
                    job_id=a["job_id"],  # ✅ correcte key (snake_case)
                    customer=customer,
                    created_at=datetime.fromisoformat(a["created"]),
                    raw_data=a,
                )
            )
            total_apps += 1
        db.commit()
        print(f"✅ {total_apps} applications opgeslagen")

        print(f"🎉 Ingest-run voltooid voor {customer}: {total_postings} postings, {total_apps} applications\n")

    except Exception as e:
        db.rollback()
        print(f"❌ Fout tijdens ingest: {e}")
    finally:
        db.close()


if __name__ == "__main__":
    ingest_once()
