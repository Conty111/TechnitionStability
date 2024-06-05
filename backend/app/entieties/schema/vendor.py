from pydantic import BaseModel
from uuid import UUID
from typing import List


class VendorBase(BaseModel):
    name: str
    country: str


class VendorCreate(VendorBase):
    pass


class VendorUpdate(VendorBase):
    pass


class Vendor(VendorBase):
    id: UUID
    products: List[UUID]  # Assuming you'll want a list of product IDs

    class Config:
        from_attributes = True
