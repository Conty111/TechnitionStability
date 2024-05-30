from sqlalchemy import Column, String
from app.entieties.models.base import Base


class NoteModel(Base):
    __tablename__ = "notes"
    title = Column(String(50), nullable=False)
    description = Column(String(50), nullable=False)
