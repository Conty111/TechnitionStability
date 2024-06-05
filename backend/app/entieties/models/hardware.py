from sqlalchemy import Column, String, Boolean, Integer, ForeignKey, Enum
from sqlalchemy.dialects.postgresql import UUID, ARRAY
from sqlalchemy.orm import relationship

from app.entieties.models.base import BaseModel, Utilization
from app.entieties.models.association import software_hardware
from app.entieties.schema.enums import Location
from app.db import Base


class HardwareModel(Base, BaseModel, Utilization):
    __tablename__ = "hardware"
    name = Column(String(50), nullable=False)
    monitoring = Column(Boolean, nullable=False, default=False)
    product_id = Column(UUID(as_uuid=True), ForeignKey("catalog.id"), nullable=False)
    hardware_type_id = Column(UUID(as_uuid=True), ForeignKey("hardware_types.id"), nullable=False)
    location = Column(Enum(Location), nullable=False)
    clusters = Column(ARRAY(String(50)), nullable=True)
    model = Column(String(150), nullable=True)
    ports_count = Column(Integer, nullable=True)

    software = relationship("SoftwareModel", secondary=software_hardware, backref="hardware")
    product = relationship("CatalogModel", back_populates="hardware")
    hardware_type = relationship("HardwareTypesModel", back_populates="hardware")


class HardwareTypesModel(Base, BaseModel):
    __tablename__ = "hardware_types"
    name = Column(String(50), nullable=False)

    hardware = relationship("HardwareModel", back_populates="hardware_type")

