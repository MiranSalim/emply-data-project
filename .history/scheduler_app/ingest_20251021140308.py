import os, requests
from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from .db import SessionLocal, Base, engine
from .models import Posting, Application

Base.metadata.create_all(bind=engine)
API_URL = os.getenv("SOURCE_API_URL")
API_KEY = os.getenv("SOURCE_API_KEY")

def fetch_postings(customer: str, media_id: str):
    url = f"{API_URL}/{customer}/postings/{media_id}"
    r = requests.get(url, headers={"x-api-key": API_KEY})
    r.raise_for_status()
    return r.json()

def fetch_applications(customer: str, start: datetime, end: datetime):
    url = f"{API_URL}/{customer}/applications/find-by-date"
    params = {"from": start.isoformat(), "to": end.isoformat()}
    r = requests.get(url, headers={"x-api-key": API_KEY}, params=params)
    r.raise_for_status()
    return r.json()

def ingest_once(customer="acme", media_id=None):
    db: Session = SessionLocal()
    try:
        # kies random media_id als niet opgegeven
        if not media_id:
            media_id = "60463526-3ba3-4587-9584-e25a96796119"

        print("→ Ophalen postings...")
        postings = fetch_postings(customer, media_id)
        for p in postings:
            db.add(Posting(
                job_id=p["job_id"],
                vacancy_id=p["vacancy_id"],
                customer=customer,
                media_id=p["media_id"],
                created_at=datetime.fromisoformat(p["created"]),
                raw_data=p,
            ))
        db.commit()

        print("→ Ophalen applications...")
        start = datetime.utcnow() - timedelta(days=90)
        end = datetime.utcnow()
        apps = fetch_applications(customer, start, end)
        for a in apps:
            db.add(Application(
                application_id=a["id"],
                job_id=a["jobId"],
                customer=customer,
                created_at=datetime.fromisoformat(a["created"]),
                raw_data=a,
            ))
        db.commit()
        print(f"✅ Ingest voltooid: {len(postings)} postings, {len(apps)} applications")
    except Exception as e:
        db.rollback()
        print("❌ Fout:", e)
    finally:
        db.close()
