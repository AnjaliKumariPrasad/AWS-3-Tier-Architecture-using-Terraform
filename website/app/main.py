from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

from app.database import SessionLocal, engine, Base
from app.schemas import ProjectCreate, TaskCreate
from app.crud import (
    create_project,
    get_projects,
    create_task,
    get_tasks,
    delete_task
)

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Task Management API"
)


def get_db():
    db = SessionLocal()

    try:
        yield db
    finally:
        db.close()


@app.get("/")
def home():
    return {
        "message": "Task Management API Running"
    }


@app.post("/projects")
def add_project(
    project: ProjectCreate,
    db: Session = Depends(get_db)
):
    return create_project(
        db,
        project.name
    )


@app.get("/projects")
def all_projects(
    db: Session = Depends(get_db)
):
    return get_projects(db)


@app.post("/tasks")
def add_task(
    task: TaskCreate,
    db: Session = Depends(get_db)
):
    return create_task(
        db,
        task.title,
        task.status,
        task.project_id
    )


@app.get("/tasks")
def all_tasks(
    db: Session = Depends(get_db)
):
    return get_tasks(db)


@app.delete("/tasks/{task_id}")
def remove_task(
    task_id: int,
    db: Session = Depends(get_db)
):
    return delete_task(
        db,
        task_id
    )