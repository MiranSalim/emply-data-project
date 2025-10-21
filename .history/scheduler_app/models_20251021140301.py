from sqlalchemy import Column, Integer, String, DateTime, JSON
from sqlalchemy.dialects.postgresql import UUID
from .db import Base

class Posting(Base):
    __tablename__ = "postings_raw"
    id = Column(Integer, primary_key=True, autoincrement=True)
    job_id = Column(Integer)
    vacancy_id = Column(UUID(as_uuid=True))
    customer = Column(String)
    media_id = Column(UUID(as_uuid=True))
    created_at = Column(DateTime)
    raw_data = Column(JSON)

class Application(Base):
    __tablename__ = "applications_raw"
    id = Column(Integer, primary_key=True, autoincrement=True)
    application_id = Column(UUID(as_uuid=True))
    job_id = Column(Integer)
    customer = Column(String)
    created_at = Column(DateTime)
    raw_data = Column(JSON)
