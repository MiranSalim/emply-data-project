from sqlalchemy.dialects.postgresql import UUID, JSON
from sqlalchemy import Column, Integer, String, DateTime, Float
import uuid
from .db import Base

class Posting(Base):
    __tablename__ = "postings"

    job_id = Column(Integer, primary_key=True)
    vacancy_id = Column(UUID(as_uuid=True), default=uuid.uuid4)
    application_form_id = Column(UUID(as_uuid=True))
    title = Column(JSON)                      # localization array
    content = Column(JSON)
    type = Column(Integer)                    # 0 = Job, 1 = TalentPool
    created = Column(DateTime)
    edited = Column(DateTime)
    deadline_utc = Column(DateTime)
    deadline = Column(DateTime)
    deadline_text = Column(JSON)
    location = Column(JSON)
    department = Column(JSON)
    tags = Column(JSON)
    data = Column(JSON)
    project_manager_user_id = Column(UUID(as_uuid=True))
    project_manager_full_name = Column(String)
    template_id = Column(UUID(as_uuid=True))
    template_title = Column(JSON)
    apply_url = Column(JSON)
    ad_url = Column(JSON)
    external_application_url = Column(String)
    time_zone = Column(String)
    media_id = Column(UUID(as_uuid=True))
    stage = Column(Integer)                   # 1 = Published ...

