from sqlalchemy import Column, String
from app.entieties.models.base import BaseModel

from app.db import Base


class NoteModel(Base, BaseModel):
    __tablename__ = "notes"
    title = Column(String(50), nullable=False)
    description = Column(String(50), nullable=False)
