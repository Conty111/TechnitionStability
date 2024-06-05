from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from typing import Type, TypeVar, Generic, List
from pydantic import BaseModel
from uuid import UUID

from app.db import Base

# Типовой параметр для моделей SQLAlchemy
ModelType = TypeVar("ModelType", bound=Base)

# Типовой параметр для схем Pydantic
CreateSchemaType = TypeVar("CreateSchemaType", bound=BaseModel)
UpdateSchemaType = TypeVar("UpdateSchemaType", bound=BaseModel)

class FabricCRUD(Generic[ModelType, CreateSchemaType, UpdateSchemaType]):
    def __init__(self, model: Type[ModelType]):
        self.model = model

    async def get(self, db: AsyncSession, id: UUID) -> ModelType:
        return await db.get(self.model, id)

    async def get_multi(self, db: AsyncSession, skip: int = 0, limit: int = 10) -> List[ModelType]:
        query = text("SELECT * FROM " + self.model.__tablename__ + f" OFFSET {skip} LIMIT {limit}")
        result = await db.execute(query)
        rows = result.fetchall()
        objects = [self.model(**row._asdict()) for row in rows]
        return objects
    
    async def create(self, db: AsyncSession, obj_in: CreateSchemaType) -> ModelType:
        obj_in_data = obj_in.model_dump()
        db_obj = self.model(**obj_in_data)
        db.add(db_obj)
        await db.commit()
        await db.refresh(db_obj)

        return db_obj

    async def update(self, db: AsyncSession, db_obj: ModelType, obj_in: UpdateSchemaType) -> ModelType:
        obj_data = db_obj.dict()
        update_data = obj_in.model_dump(exclude_unset=True)
        for field in obj_data:
            if field in update_data:
                setattr(db_obj, field, update_data[field])
        await db.commit()
        await db.refresh(db_obj)
        return db_obj

    async def remove(self, db: AsyncSession, id: UUID) -> ModelType:
        obj = await db.get(self.model, id)
        if obj:
            db.delete(obj)
            await db.commit()
        return obj
