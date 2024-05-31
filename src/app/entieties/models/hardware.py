from sqlalchemy import Column, String, Boolean, Integer, ARRAY, ForeignKey, Enum
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.entieties.models.base import Base, Utilization
from app.entieties.models.association import software_hardware
from app.entieties.schema.enums import Location


class HardwareModel(Base, Utilization):
    __tablename__ = "virtual_machine"
    name = Column(String(50), nullable=False)
    monitoring = Column(Boolean, nullable=False, default=False)
    system_id = Column(UUID(as_uuid=True), ForeignKey("info_system.id"), nullable=False)
    location = Column(Enum(Location), nullable=False)
    internal_support = Column(Boolean, nullable=False, default=False)
    clusters = Column(ARRAY(String(50)), nullable=True)
    model = Column(String(150), nullable=True)
    ports_count = Column(Integer, nullable=True)

    software = relationship("SoftwareModel", secondary=software_hardware, back_populates="hardware")
    product = relationship("CatalogModel", back_populates="hardware")

