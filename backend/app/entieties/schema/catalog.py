from pydantic import BaseModel
from uuid import UUID

from app.entieties.schema.enums import ProductType

class CatalogBase(BaseModel):
    name: str
    vendor_id: UUID
    support: bool = False
    product: ProductType
    version: str

class CatalogCreate(CatalogBase):
    pass

class CatalogUpdate(CatalogBase):
    pass

class Catalog(CatalogBase):
    id: UUID

    class Config:
        from_attributes = True
