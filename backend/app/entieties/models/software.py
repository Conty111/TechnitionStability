from sqlalchemy import Column, String, Boolean, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.entieties.models.association import host_software
from app.entieties.models.base import BaseModel
from app.db import Base


class SoftwareModel(Base, BaseModel):
    __tablename__ = "software"
    name = Column(String(50), nullable=False)
    product_id = Column(UUID(as_uuid=True), ForeignKey("catalog.id"), nullable=True)
    software_type_id = Column(UUID(as_uuid=True), ForeignKey("software_types.id"), nullable=False)
    
    product = relationship("CatalogModel", back_populates="software")
    hosts = relationship("VirtualMachineModel", secondary=host_software, back_populates="software")
    software_type = relationship("SoftwareTypesModel", back_populates="software")


class SoftwareTypesModel(Base, BaseModel):
    __tablename__ = "software_types"
    name = Column(String(50), nullable=False)

    software = relationship("SoftwareModel", back_populates="software_types")

