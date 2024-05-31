from sqlalchemy import Column, String, Boolean, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.entieties.models.association import host_software
from app.entieties.models.base import Base


class SoftwareModel(Base):
    __tablename__ = "software"
    name = Column(String(50), nullable=False)
    product_id = Column(UUID(as_uuid=True), ForeignKey("catalog.id"), nullable=False)
    soft_type = Column(String(100), nullable=False)
    vendor_support = Column(Boolean, nullable=False, default=False)

    product = relationship("CatalogModel", back_populates="software")
    hosts = relationship("VirtualMachineModel", secondary=host_software, back_populates="software")
