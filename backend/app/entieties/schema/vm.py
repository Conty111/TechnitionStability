from pydantic import BaseModel
from uuid import UUID
from typing import List
from app.entieties.schema.software import Software  # Assuming you have a schema for Software


class VirtualMachineBase(BaseModel):
    name: str
    monitoring: bool
    system_id: UUID
    srk: bool
    location: str
    cluster: str


class VirtualMachineCreate(VirtualMachineBase):
    pass


class VirtualMachineUpdate(VirtualMachineBase):
    pass


class VirtualMachine(VirtualMachineBase):
    id: UUID
    software: List[Software]  # Assuming you have a schema for Software
    info_system_id: UUID

    class Config:
        from_attributes = True
