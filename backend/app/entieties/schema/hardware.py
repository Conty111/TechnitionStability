from pydantic import BaseModel
from uuid import UUID
from typing import Optional, List

from app.entieties.schema.enums import Location


class HardwareBase(BaseModel):
    name: str
    monitoring: bool
    product_id: UUID
    hardware_type_id: UUID
    location: Location
    internal_support: bool
    clusters: Optional[List[str]] = None
    model: Optional[str] = None
    ports_count: Optional[int] = None


class HardwareCreate(HardwareBase):
    pass


class HardwareUpdate(HardwareBase):
    pass


class Hardware(HardwareBase):
    id: UUID
    software: List[UUID]  # Assuming you'll want a list of software IDs

    class Config:
        orm_mode = True


class HardwareTypeBase(BaseModel):
    name: str


class HardwareTypeCreate(HardwareTypeBase):
    pass


class HardwareTypeUpdate(HardwareTypeBase):
    pass


class HardwareType(HardwareTypeBase):
    id: UUID
    hardware: List[UUID]  # Assuming you'll want a list of hardware IDs

    class Config:
        orm_mode = True
