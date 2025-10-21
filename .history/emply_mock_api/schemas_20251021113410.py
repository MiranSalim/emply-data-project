# emply_mock_api/schemas.py
from pydantic import BaseModel
from datetime import datetime
from typing import List, Optional

class ApplicationOut(BaseModel):
    id: int
    candidate_name: str
    date_applied: datetime

    class Config:
        orm_mode = True

class PostingOut(BaseModel):
    id: int
    title: str
    location: Optional[str]
    status: str
    published_at: datetime
    media_id: str
    customer: str
    applications: List[ApplicationOut] = []

    class Config:
        orm_mode = True
