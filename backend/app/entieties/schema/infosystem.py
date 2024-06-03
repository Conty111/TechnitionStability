from pydantic import BaseModel
from uuid import UUID
from typing import Optional, List


class InfoSystemBase(BaseModel):
    name: str
    criticality_ratio: Optional[float]

class InfoSystemCreate(InfoSystemBase):
    pass

class InfoSystemUpdate(InfoSystemBase):
    pass

class InfoSystem(InfoSystemBase):
    id: UUID
    hosts: List[UUID]  # Assuming you'll want a list of host IDs here

    class Config:
        orm_mode = True
