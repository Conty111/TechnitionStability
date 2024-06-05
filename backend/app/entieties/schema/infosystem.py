from pydantic import BaseModel
from uuid import UUID
from typing import Optional, List
from datetime import datetime


class InfoSystemBase(BaseModel):
    name: str
    criticality_ratio: Optional[float] = None

class InfoSystemCreate(InfoSystemBase):
    pass

class InfoSystemUpdate(InfoSystemBase):
    pass

class InfoSystem(InfoSystemBase):
    id: UUID
    created_at: datetime
    hosts: Optional[List[UUID]] = None # Assuming you'll want a list of host IDs here

    class Config:
        from_attributes = True
