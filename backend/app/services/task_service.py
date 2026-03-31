from sqlalchemy.orm import Session
from app.models.task_model import Task
from app.schemas.task_schema import TaskCreate, TaskUpdate
import asyncio

# CREATE
async def create_task(task: TaskCreate, db: Session):
    await asyncio.sleep(2)

    db_task = Task(**task.dict())
    db.add(db_task)
    db.commit()
    db.refresh(db_task)
    return db_task


# GET ALL
def get_tasks(db: Session, search: str = "", status: str = ""):
    query = db.query(Task)

    if search:
        query = query.filter(Task.title.ilike(f"%{search}%"))

    if status:
        query = query.filter(Task.status == status)

    return query.all()


# UPDATE (✅ FIXED)
async def update_task(task_id: int, task: TaskUpdate, db: Session):
    await asyncio.sleep(2)

    db_task = db.query(Task).filter(Task.id == task_id).first()

    if not db_task:
        return None

    for key, value in task.dict().items():
        setattr(db_task, key, value)

    db.commit()
    db.refresh(db_task)
    return db_task


# DELETE
def delete_task(task_id: int, db: Session):
    db_task = db.query(Task).filter(Task.id == task_id).first()

    if not db_task:
        return False

    db.delete(db_task)
    db.commit()
    return True