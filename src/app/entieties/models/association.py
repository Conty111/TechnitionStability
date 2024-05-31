from sqlalchemy import Table, Column, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from app.db import Base


software_hardware = Table(
    'software_hardware',
    Base.metadata,
    hardware_id = Column(UUID(as_uuid=True), ForeignKey("hardware.id"), nullable=False),
    software_id = Column(UUID(as_uuid=True), ForeignKey("software.id"), nullable=False)
)

host_software = Table(
    'host_software',
    Base.metadata,
    host_id = Column(UUID(as_uuid=True), ForeignKey("virtual_machine.id"), nullable=False),
    software_id = Column(UUID(as_uuid=True), ForeignKey("software.id"), nullable=False)
)