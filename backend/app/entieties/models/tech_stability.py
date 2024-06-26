from sqlalchemy import Column, Float, DateTime, BigInteger, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.dialects.postgresql import UUID

from app.db import Base


class HardwareTechStabilityModel(Base):
    __tablename__ = "hardware_tech_stability"
    id = Column(BigInteger, primary_key=True, autoincrement=True)
    created_at = Column(DateTime, nullable=False)
    info_system_id = Column(UUID(as_uuid=True), ForeignKey("info_system.id"), nullable=False)
    
    vendor_support = Column(Float, nullable=False)
    purchase_available = Column(Float, nullable=True)
    equipment_wear = Column(Float, nullable=True)
    monitoring_coverage = Column(Float, nullable=False)
    cpu_util = Column(Float, nullable=False)
    ram_util = Column(Float, nullable=False)
    mem_util = Column(Float, nullable=False)
    compliance_standarts = Column(Float, nullable=True)

    info_system = relationship("InfoSystemModel", backref="hardware_tech_stability")


class SoftwareTechStabilityModel(Base):
    __tablename__ = "software_tech_stability"
    id = Column(BigInteger, primary_key=True, autoincrement=True)
    created_at = Column(DateTime, nullable=False)
    info_system_id = Column(UUID(as_uuid=True), ForeignKey("info_system.id"), nullable=False)
    
    vendor_support = Column(Float, nullable=False)
    monitoring_coverage = Column(Float, nullable=False)
    cpu_util = Column(Float, nullable=False)
    ram_util = Column(Float, nullable=False)
    mem_util = Column(Float, nullable=False)
    srk = Column(Float, nullable=False)
    compliance_standarts = Column(Float, nullable=False)
    purchase_available = Column(Float, nullable=False)

    info_system = relationship("InfoSystemModel", backref="software_tech_stability")
