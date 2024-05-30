from sqlalchemy import Column, String, Enum, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.entieties.models.base import Base
from app.entieties.schema.catalog import ProductType


class CatalogModel(Base):
    __tablename__ = "catalog"
    name = Column(String(50), nullable=False)
    vendor_id = Column(UUID(as_uuid=True), ForeignKey("vendors.id"), nullable=False)
    product = Column(Enum(ProductType), nullable=False)
    version = Column(String, nullable=False)
