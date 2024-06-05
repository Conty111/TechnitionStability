from pydantic import BaseModel
from uuid import UUID
from typing import List


class SoftwareBase(BaseModel):
    name: str
    product_id: UUID
    software_type_id: UUID


class SoftwareCreate(SoftwareBase):
    pass


class SoftwareUpdate(SoftwareBase):
    pass


class Software(SoftwareBase):
    id: UUID
    hosts: List[UUID]  # Assuming you'll want a list of host IDs here

    class Config:
        from_attributes = True


class SoftwareTypeBase(BaseModel):
    name: str


class SoftwareTypeCreate(SoftwareTypeBase):
    pass


class SoftwareTypeUpdate(SoftwareTypeBase):
    pass


class SoftwareType(SoftwareTypeBase):
    id: UUID
    software: List[UUID]  # Assuming you'll want a list of software IDs here

    class Config:
        from_attributes = True
