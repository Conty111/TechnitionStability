from sqlalchemy import Column, String, Boolean, Enum, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID
from app.entieties.models.base import Base
from app.entieties.schema.catalog import ProductType



class CatalogModel(Base):
    __tablename__ = "catalog"
    name = Column(String(50), nullable=False)
    vendor_id = Column(UUID(as_uuid=True), ForeignKey("vendors.id"), nullable=False)
    support = Column(Boolean, nullable=False, default=False)
    product = Column(Enum(ProductType), nullable=False)
    version = Column(String, nullable=False)

    vendor = relationship("VendorModel", back_populates="catalog")
    hardware = relationship("HardwareModel", back_populates="catalog")
    software = relationship("SoftwareModel", back_populates="catalog")
