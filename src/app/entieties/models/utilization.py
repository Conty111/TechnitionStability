from sqlalchemy import Column, Float
from sqlalchemy.ext.declarative import as_declarative, declared_attr


@as_declarative()
class Utilization:
    cpu_utilization = Column(Float, nullable=True)
    ram_utilization = Column(Float, nullable=True)
    disk_mem_utilization = Column(Float, nullable=True)

    @declared_attr
    def __tablename__(cls):
        return cls.__name__.lower()
