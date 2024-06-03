from sqlalchemy import Column, String, Float
from sqlalchemy.orm import relationship

from app.entieties.models.base import BaseModel
from app.db import Base


class InfoSystemModel(Base, BaseModel):
    __tablename__ = "info_system"
    name = Column(String(50), nullable=False)
    criticality_ratio = Column(Float, nullable=True)
    
    hosts = relationship("VirtualMachineModel", back_populates="info_system")

