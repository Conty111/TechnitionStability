from sqlalchemy import Column, DateTime, Float
from sqlalchemy.orm import Mapped
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.ext.declarative import as_declarative, declared_attr
from sqlalchemy.sql import func

import uuid

@as_declarative()
class BaseModel:
    id: Mapped[UUID] = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, unique=True, nullable=False)
    created_at: Mapped[DateTime] = Column(DateTime, default=func.now(), nullable=False)
    deleted_at: Mapped[DateTime] = Column(DateTime, nullable=True)

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()


@as_declarative()
class Utilization:
    cpu_utilization: Mapped[float] = Column(Float, nullable=True)
    ram_utilization: Mapped[float] = Column(Float, nullable=True)
    disk_mem_utilization: Mapped[float] = Column(Float, nullable=True)

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()
