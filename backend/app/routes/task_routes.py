from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.schemas.task_schema import TaskCreate, TaskUpdate, TaskResponse
from app.services.task_service import (
    create_task,
    get_tasks,
    update_task,
    delete_task,
)
from app.utils.dependencies import get_db

router = APIRouter(prefix="/tasks", tags=["Tasks"])


@router.post("/", response_model=TaskResponse)
async def add_task(task: TaskCreate, db: Session = Depends(get_db)):
    return await create_task(task, db)


@router.get("/", response_model=List[TaskResponse])
def fetch_tasks(search: str = "", status: str = "", db: Session = Depends(get_db)):
    return get_tasks(db, search, status)


@router.put("/{task_id}")
async def edit_task(task_id: int, task: TaskUpdate, db: Session = Depends(get_db)):
    updated = await update_task(task_id, task, db)

    if not updated:
        raise HTTPException(status_code=404, detail="Task not found")

    return updated


@router.delete("/{task_id}")
def remove_task(task_id: int, db: Session = Depends(get_db)):
    success = delete_task(task_id, db)

    if not success:
        raise HTTPException(status_code=404, detail="Task not found")

    return {"message": "Task deleted"}