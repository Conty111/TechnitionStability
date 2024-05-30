from sqlalchemy import Column, String
from app.entieties.models.base import Base


class VendorModel(Base):
    __tablename__ = "vendors"
    name = Column(String(50), nullable=False)
    country = Column(String(50), nullable=False)
