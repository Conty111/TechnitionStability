from typing import List

from sqlalchemy import Column, String, Boolean, ForeignKey, Enum
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship, Mapped

from app.entieties.models.base import BaseModel, Utilization
from app.entieties.models.association import host_software
from app.entieties.models.software import SoftwareModel
from app.entieties.models.infosystem import InfoSystemModel
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

    software: Mapped[List[SoftwareModel]] = relationship("SoftwareModel", secondary=host_software, back_populates="hosts")
    info_system: Mapped[InfoSystemModel] = relationship("InfoSystemModel", back_populates="hosts")
