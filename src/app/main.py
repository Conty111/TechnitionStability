from contextlib import asynccontextmanager
from fastapi import FastAPI
from app.api import notes, ping
from app.db import async_session, metadata, engine


app = FastAPI()

@asynccontextmanager
async def lifespan():
    async with engine.begin() as conn:
        await conn.run_sync(metadata.create_all)
    await async_session.connect()
    yield
    await async_session.disconnect()

app.include_router(ping.router)
# app.include_router(notes.router, prefix="/notes", tags=["notes"])