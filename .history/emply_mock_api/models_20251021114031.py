# emply_mock_api/models.py
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from .db import Base

class Posting(Base):
    __tablename__ = "postings"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    location = Column(String)
    status = Column(String)
    published_at = Column(DateTime, default=datetime.utcnow)
    media_id = Column(String, index=True)
    customer = Column(String, index=True)

    applications = relationship("Application", back_populates="posting")

class Application(Base):
    __tablename__ = "applications"

    id = Column(Integer, primary_key=True, index=True)
    posting_id = Column(Integer, ForeignKey("postings.id"))
    candidate_name = Column(String)
    date_applied = Column(DateTime, default=datetime.utcnow)

    posting = relationship("Posting", back_populates="applications")
