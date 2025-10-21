from apscheduler.schedulers.background import BackgroundScheduler
from .ingest import ingest_once
import time

def start_scheduler():
    scheduler = BackgroundScheduler()
    scheduler.add_job(ingest_once, "interval", minutes=5)  # elke 5 min
    scheduler.start()
    print("⏱️ Scheduler gestart (interval=5min). Ctrl+C om te stoppen.")
    try:
        while True:
            time.sleep(2)
    except (KeyboardInterrupt, SystemExit):
        scheduler.shutdown()

if __name__ == "__main__":
    start_scheduler()
