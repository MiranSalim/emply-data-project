import os
from datetime import datetime
from typing import Optional, List
from fastapi import FastAPI, Depends, Header, HTTPException, Query
from sqlalchemy.orm import Session
from .db import SessionLocal
from .models import Posting, Application
from .schemas import PostingOut, ApplicationOut
from sqlalchemy import String

API_KEY = os.getenv("API_KEY", "test")

app = FastAPI(title="Mock Emply API (PostgreSQL)")

# --- DB session dependency ---
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# --- Simple header auth like Emply x-api-key required ---
async def verify_api_key(x_api_key: Optional[str] = Header(default=None)):
    if not x_api_key:
        raise HTTPException(status_code=401, detail="x-api-key header missing")
    # Eventueel key matchen met .env
    if API_KEY and x_api_key != API_KEY:
        raise HTTPException(status_code=401, detail="invalid x-api-key")

# --- Routes ---

@app.get(
    "/v1/{customer}/postings/{mediaId}",
    response_model=List[PostingOut],
    dependencies=[Depends(verify_api_key)],
)
def get_postings(customer: str, mediaId: str, db: Session = Depends(get_db)):
    """
    Retourneert postings gefilterd op customer + mediaId (zoals echte integratie).
    """
    try:
        postings = (
            db.query(Posting)
            .filter(Posting.customer == customer)
            .filter(Posting.media_id.cast(String) == mediaId)
            .all()
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"DB error: {e}")
    return postings


@app.get(
    "/v1/{customer}/applications/find-by-date",
    response_model=List[ApplicationOut],
    dependencies=[Depends(verify_api_key)],
)
def get_applications(
    customer: str,
    from_date: str = Query(..., alias="from"),
    to_date: str = Query(..., alias="to"),
    db: Session = Depends(get_db),
):
    """
    Retourneert applications voor een klant binnen datumbereik (op Application.created).
    """
    try:
        from_dt = datetime.fromisoformat(from_date)
        to_dt = datetime.fromisoformat(to_date)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid date format (use ISO 8601: YYYY-MM-DD or full date-time)")

    try:
        # Filter via join op Posting zodat 'customer' klopt
        apps = (
            db.query(Application)
            .join(Posting, Application.job_id == Posting.job_id)
            .filter(Posting.customer == customer)
            .filter(Application.created >= from_dt, Application.created <= to_dt)
            .all()
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"DB error: {e}")

    return apps
