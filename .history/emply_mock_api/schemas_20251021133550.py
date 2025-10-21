from datetime import datetime
from typing import Optional, Any, List
from uuid import UUID as UUID_t
from pydantic import BaseModel, Field

# Pydantic v2-compat config
class ORMModel(BaseModel):
    model_config = {
        "from_attributes": True,
        "populate_by_name": True,
    }

# -------- Application --------
class ApplicationOut(ORMModel):
    id: UUID_t
    number: Optional[int] = None
    vacancyId: Optional[UUID_t] = Field(default=None, alias="vacancy_id")
    email: Optional[str] = None
    firstName: Optional[str] = Field(default=None, alias="first_name")
    lastName: Optional[str] = Field(default=None, alias="last_name")
    middleName: Optional[str] = Field(default=None, alias="middle_name")
    created: datetime
    updated: datetime
    status: int
    jobId: int = Field(alias="job_id")
    candidateId: Optional[UUID_t] = Field(default=None, alias="candidate_id")
    stage: Optional[Any] = None
    disqualifyReason: Optional[Any] = Field(default=None, alias="disqualify_reason")
    source: Optional[Any] = None

# -------- Posting --------
class PostingOut(ORMModel):
    jobId: int = Field(alias="job_id")
    vacancyId: UUID_t = Field(alias="vacancy_id")
    applicationFormId: Optional[UUID_t] = Field(default=None, alias="application_form_id")
    advertisements: Optional[Any] = None
    title: Optional[Any] = None
    content: Optional[Any] = None
    type: int
    created: datetime
    edited: datetime
    deadlineUTC: Optional[datetime] = Field(default=None, alias="deadline_utc")
    deadline: Optional[datetime] = None
    deadlineText: Optional[Any] = Field(default=None, alias="deadline_text")
    location: Optional[Any] = None
    department: Optional[Any] = None
    tags: Optional[Any] = None
    data: Optional[Any] = None
    projectManagerUserId: Optional[UUID_t] = Field(default=None, alias="project_manager_user_id")
    projectManagerFullName: Optional[str] = Field(default=None, alias="project_manager_full_name")
    templateId: Optional[UUID_t] = Field(default=None, alias="template_id")
    templateTitle: Optional[Any] = Field(default=None, alias="template_title")
    applyUrl: Optional[Any] = Field(default=None, alias="apply_url")
    adUrl: Optional[Any] = Field(default=None, alias="ad_url")
    externalApplicationUrl: Optional[str] = Field(default=None, alias="external_application_url")
    timeZone: Optional[str] = Field(default=None, alias="time_zone")
    mediaId: UUID_t = Field(alias="media_id")
    stage: int

