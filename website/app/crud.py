from sqlalchemy.orm import Session

from app.models import Project, Task


def create_project(db: Session, name: str):
    project = Project(name=name)

    db.add(project)

    db.commit()

    db.refresh(project)

    return project


def get_projects(db: Session):
    return db.query(Project).all()


def create_task(
    db: Session,
    title: str,
    status: str,
    project_id: int
):
    task = Task(
        title=title,
        status=status,
        project_id=project_id
    )

    db.add(task)

    db.commit()

    db.refresh(task)

    return task


def get_tasks(db: Session):
    return db.query(Task).all()


def delete_task(
    db: Session,
    task_id: int
):
    task = (
        db.query(Task)
        .filter(Task.id == task_id)
        .first()
    )

    if task:
        db.delete(task)

        db.commit()

    return task