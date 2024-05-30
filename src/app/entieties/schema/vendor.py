from pydantic import BaseModel, Field
import uuid
from datetime import datetime


class VendorSchema(BaseModel):
    name: str = Field(..., min_length=3, max_length=50)
    country: str = Field(..., min_length=2, max_length=50)

class VendorDB(VendorSchema):
    id: uuid.UUID
    created_at: datetime
    deleted_at: datetime = None
