from sqlalchemy import Column, String, Boolean, ForeignKey, Enum
from sqlalchemy.dialects.postgresql import UUID
from app.entieties.models.base import Base
from app.entieties.models.utilization import Utilization

from app.entieties.schema.enums import Location


class VirtualMachineModel(Base, Utilization):
    __tablename__ = "virtual_machine"
    name = Column(String(50), nullable=False)
    monitoring = Column(Boolean, nullable=False, default=False)
    system_id = Column(UUID(as_uuid=True), ForeignKey("info_systems.id"), nullable=False)
    srk = Column(Boolean, nullable=False, default=False)
    location = Column(Enum(Location), nullable=False)
    cluster = Column(String(50), nullable=False)
