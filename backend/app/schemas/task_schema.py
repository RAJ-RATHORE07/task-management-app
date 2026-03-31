from pydantic import BaseModel
from datetime import date
from typing import Optional
from enum import Enum

# ✅ STRICT STATUS ENUM
class StatusEnum(str, Enum):
    todo = "To-Do"
    in_progress = "In Progress"
    done = "Done"

class TaskBase(BaseModel):
    title: str
    description: str
    due_date: date
    status: StatusEnum   # ✅ FIX HERE
    blocked_by: Optional[int] = None

class TaskCreate(TaskBase):
    pass

class TaskUpdate(TaskBase):
    pass

class TaskResponse(TaskBase):
    id: int

    class Config:
        orm_mode = True