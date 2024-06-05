from sqlalchemy import Column, String
from sqlalchemy.orm import relationship, Mapped

from app.entieties.models.base import BaseModel
from app.db import Base


class VendorModel(Base, BaseModel):
    __tablename__ = "vendors"
    name = Column(String(50), nullable=False)
    country = Column(String(50), nullable=False)

    products = relationship("CatalogModel", backref="vendors")
    