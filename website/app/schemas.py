from pydantic import BaseModel


# ---------- PROJECT ----------

class ProjectCreate(BaseModel):
    name: str


class ProjectResponse(ProjectCreate):
    id: int

    class Config:
        from_attributes = True


# ---------- TASK ----------

class TaskCreate(BaseModel):
    title: str
    status: str
    project_id: int


class TaskResponse(TaskCreate):
    id: int

    class Config:
        from_attributes = True