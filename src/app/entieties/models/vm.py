from sqlalchemy import Column, String, Boolean, ForeignKey, Enum
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship

from app.entieties.models.base import BaseModel, Utilization
from app.entieties.models.association import host_software
from app.entieties.schema.enums import Location
from app.db import Base


class VirtualMachineModel(Base, BaseModel, Utilization):
    __tablename__ = "virtual_machine"
    name = Column(String(50), nullable=False)
    monitoring = Column(Boolean, nullable=False, default=False)
    system_id = Column(UUID(as_uuid=True), ForeignKey("info_system.id"), nullable=False)
    srk = Column(Boolean, nullable=False, default=False)
    location = Column(Enum(Location), nullable=False)
    cluster = Column(String(50), nullable=False)

    software = relationship("SoftwareModel", secondary=host_software, back_populates="virtual_machine")
    info_system = relationship("InfoSystemModel", back_populates="virtual_machine")
