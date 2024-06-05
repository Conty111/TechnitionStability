from dotenv import load_dotenv
from sqlalchemy import MetaData
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker, declarative_base, registry
import os

load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")

metadata = MetaData()
Base = declarative_base(metadata=metadata)
reg = registry.as_declarative_base(Base)

engine = create_async_engine(DATABASE_URL)
AsyncSessionLocal = sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)

async def get_db():
    db = AsyncSessionLocal()
    try:
        yield db
    finally:
        await db.close()