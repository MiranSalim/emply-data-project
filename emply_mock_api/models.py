import uuid
from datetime import datetime
from sqlalchemy import Column, Integer, String, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import UUID, JSONB
from sqlalchemy.orm import relationship
from .db import Base

class Posting(Base):
    """
    Posting (vereenvoudigd naar kolommen + JSONB voor geneste Emply-structuren).
    """
    __tablename__ = "postings"

    # "Job's identifier" — gebruiken we als primary key
    job_id = Column(Integer, primary_key=True)
    # "Vacancy identifier of a job"
    vacancy_id = Column(UUID(as_uuid=True), nullable=False, default=uuid.uuid4, index=True)

    # Vaak handig voor filtering zoals echte API: media bron + klant
    media_id = Column(UUID(as_uuid=True), nullable=False, default=uuid.uuid4, index=True)
    customer = Column(String, nullable=False, index=True)

    application_form_id = Column(UUID(as_uuid=True), nullable=True)

    # Lokalisaties en andere geneste blokken naar JSONB
    advertisements = Column(JSONB, nullable=True)
    title = Column(JSONB, nullable=True)
    content = Column(JSONB, nullable=True)
    type = Column(Integer, nullable=False, default=0)  # 0=Job,1=TalentPool

    created = Column(DateTime, default=datetime.utcnow)
    edited = Column(DateTime, default=datetime.utcnow)

    deadline_utc = Column(DateTime, nullable=True)
    deadline = Column(DateTime, nullable=True)
    deadline_text = Column(JSONB, nullable=True)

    location = Column(JSONB, nullable=True)   # JobLocation
    department = Column(JSONB, nullable=True) # JobDepartment
    tags = Column(JSONB, nullable=True)       # array
    data = Column(JSONB, nullable=True)       # array

    project_manager_user_id = Column(UUID(as_uuid=True), nullable=True)
    project_manager_full_name = Column(String, nullable=True)

    template_id = Column(UUID(as_uuid=True), nullable=True)
    template_title = Column(JSONB, nullable=True)

    apply_url = Column(JSONB, nullable=True)
    ad_url = Column(JSONB, nullable=True)
    external_application_url = Column(String, nullable=True)

    time_zone = Column(String, nullable=True)
    stage = Column(Integer, nullable=False, default=1)  # 1=Published,2=Unpublished,...

    applications = relationship("Application", back_populates="posting", cascade="all,delete-orphan")


class Application(Base):
    """
    Application (Emply-vorm, nested velden in JSONB).
    """
    __tablename__ = "applications"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    number = Column(Integer, nullable=True)

    # Koppeling naar posting via job_id; vacancy_id bewaren we ook apart
    job_id = Column(Integer, ForeignKey("postings.job_id"), index=True)
    vacancy_id = Column(UUID(as_uuid=True), nullable=True)

    email = Column(String, nullable=True)
    first_name = Column(String, nullable=True)
    last_name = Column(String, nullable=True)
    middle_name = Column(String, nullable=True)

    created = Column(DateTime, default=datetime.utcnow)
    updated = Column(DateTime, default=datetime.utcnow)

    status = Column(Integer, nullable=False, default=1)  # 0=Inactive,1=Active
    candidate_id = Column(UUID(as_uuid=True), nullable=True)

    # Geneste structuren (Localization/BaseSource)
    stage = Column(JSONB, nullable=True)
    disqualify_reason = Column(JSONB, nullable=True)
    source = Column(JSONB, nullable=True)

    posting = relationship("Posting", back_populates="applications")
