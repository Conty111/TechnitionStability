from pydantic import BaseModel, Field
import uuid
from datetime import datetime


class NoteSchema(BaseModel):
    title: str = Field(..., min_length=3, max_length=50)
    description: str = Field(..., min_length=3, max_length=50)


class NoteDB(NoteSchema):
    id: uuid.UUID
    created_at: datetime
    deleted_at: datetime = None
