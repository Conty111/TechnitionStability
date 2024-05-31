from sqlalchemy import Column, DateTime, Float
from sqlalchemy.dialects.postgresql import UUID
import uuid
from sqlalchemy.ext.declarative import as_declarative, declared_attr
from sqlalchemy.sql import func


@as_declarative()
class Base:
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4, unique=True, nullable=False)
    created_at = Column(DateTime, default=func.now(), nullable=False)
    deleted_at = Column(DateTime, nullable=True)

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()


@as_declarative()
class Utilization:
    cpu_utilization = Column(Float, nullable=True)
    ram_utilization = Column(Float, nullable=True)
    disk_mem_utilization = Column(Float, nullable=True)

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()
