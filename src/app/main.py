from contextlib import asynccontextmanager
from fastapi import FastAPI
from app.api import notes, ping
from app.db.db import engine, metadata, database

app = FastAPI()

@asynccontextmanager
async def lifespan():
    await database.connect()
    yield
    await database.disconnect()

app.include_router(ping.router)
app.include_router(notes.router, prefix="/notes", tags=["notes"])