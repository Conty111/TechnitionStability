from pydantic import BaseModel, Field
import uuid
from datetime import datetime

from app.entieties.schema.enums import ProductType


class CatalogSchema(BaseModel):
    name: str = Field(..., min_length=3, max_length=50)
    vendor_id: uuid.UUID
    product: ProductType
    version: str

class CatalogDB(CatalogSchema):
    id: uuid.UUID
    created_at: datetime
    deleted_at: datetime = None
