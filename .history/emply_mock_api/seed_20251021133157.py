import uuid
from random import choice, randint
from datetime import datetime, timedelta
from faker import Faker
from sqlalchemy.orm import Session
from .db import Base, engine, SessionLocal
from .models import Posting, Application

fake = Faker()

CUSTOMERS = ["acme", "globex", "initech"]

def seed():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)

    db: Session = SessionLocal()

    postings = []
    for _ in range(30):
    created_dt = fake.date_time_between(start_date="-120d", end_date="-10d")
    edited_dt = created_dt + timedelta(days=randint(0, 20))
    deadline_dt = created_dt + timedelta(days=randint(10, 60))

    # eerst de lat/lon genereren vóór je Posting maakt
    lat = float(fake.latitude())
    lon = float(fake.longitude())
    location = {"address": fake.address(), "latitude": lat, "longitude": lon}

    p = Posting(
        job_id=randint(1000, 9999),
        vacancy_id=uuid.uuid4(),
        media_id=uuid.uuid4(),
        customer=choice(CUSTOMERS),
        application_form_id=uuid.uuid4() if randint(0, 1) else None,
        advertisements={"localization": [{"locale": "en", "value": "Standard Ad"}]},
        title={"localization": [{"locale": "en", "value": fake.job()}]},
        content={"localization": [{"locale": "en", "value": fake.paragraph(nb_sentences=4)}]},
        type=0,
        created=created_dt,
        edited=edited_dt,
        deadline_utc=deadline_dt,
        deadline=deadline_dt,
        deadline_text={"localization": [{"locale": "en", "value": deadline_dt.isoformat()}]},
        location=location,
        department={
            "id": str(uuid.uuid4()),
            "title": {"localization": [{"locale": "en", "value": fake.job()}]},
        },
        tags=["python", "fastapi", "sqlalchemy"] if randint(0, 1) else None,
        data=[{"key": "employment", "value": choice(["FT", "PT", "Contract"])}],
        project_manager_user_id=uuid.uuid4() if randint(0, 1) else None,
        project_manager_full_name=fake.name(),
        template_id=uuid.uuid4() if randint(0, 1) else None,
        template_title={"localization": [{"locale": "en", "value": "Standard Template"}]},
        apply_url={"localization": [{"locale": "en", "value": "https://example.com/apply"}]},
        ad_url={"localization": [{"locale": "en", "value": "https://example.com/ad"}]},
        external_application_url="https://example.com/apply" if randint(0, 1) else None,
        time_zone="Europe/Amsterdam",
        stage=choice([1, 1, 1, 2, 3]),  # vaker Published
    )
    postings.append(p)
    db.add(p)


    db.commit()

    # Applications verdelen over postings
    for p in postings:
        for _ in range(randint(0, 8)):
            created = p.created + timedelta(days=randint(0, 50))
            a = Application(
                number=randint(10000, 99999),
                job_id=p.job_id,
                vacancy_id=p.vacancy_id,
                email=fake.email() if randint(0, 1) else None,
                first_name=fake.first_name(),
                last_name=fake.last_name(),
                middle_name=fake.first_name() if randint(0, 3) == 0 else None,
                created=created,
                updated=created + timedelta(days=randint(0, 10)),
                status=choice([0, 1, 1, 1]),
                candidate_id=uuid.uuid4(),
                stage={"localization": [{"locale": "en", "value": choice(["Screening", "Interview", "Offer"])}]},
                disqualify_reason=None if randint(0, 3) else {"localization": [{"locale": "en", "value": "Not a fit"}]},
                source={"type": choice(["LinkedIn", "Referral", "Website", "Agency"])},
            )
            db.add(a)

    db.commit()
    db.close()
    print("✅ Seed voltooid: postings + applications gevuld.")

if __name__ == "__main__":
    seed()
