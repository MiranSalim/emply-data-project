posting = Posting(
    job_id=fake.random_int(1000, 9999),
    vacancy_id=uuid.uuid4(),
    title={"localization": [{"locale": "en", "value": fake.job()}]},
    type=0,
    created=fake.date_time_between(start_date="-90d", end_date="now"),
    edited=fake.date_time_between(start_date="-30d", end_date="now"),
    location={"address": fake.address()},
    project_manager_full_name=fake.name(),
    media_id=uuid.uuid4(),
    stage=1,
)
