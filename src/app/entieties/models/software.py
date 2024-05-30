from sqlalchemy import Column, String, Boolean, Enum, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.entieties.models.base import Base
from app.entieties.schema.catalog import ProductType


class SoftwareModel(Base):
    __tablename__ = "software"
    name = Column(String(50), nullable=False)
    product_id = Column(UUID(as_uuid=True), ForeignKey("catalog.id"), nullable=False)
    soft_type = Column(String(100), nullable=False)
    vendor_support = Column(Boolean, nullable=False, default=False)
