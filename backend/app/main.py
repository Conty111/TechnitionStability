from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api import ping, infosystem
from app.db import metadata, engine, get_db


app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://frontend",
    "http://frontend:3000",
    "http://0.0.0.0:3000",
    "http://0.0.0.0",
    "http://localhost:8000",
    "http://127.0.0.1:3000",   # Добавить это
    "http://127.0.0.1:8000",   # Добавить это
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@asynccontextmanager
async def lifespan():
    async with engine.begin() as conn:
        await conn.run_sync(metadata.create_all)
    await get_db().connect()
    yield
    await get_db().disconnect()


app.include_router(ping.router, tags=["ping"])
app.include_router(infosystem.router, prefix="/infosystems", tags=["info_system", "main"])
# app.include_router(notes.router, prefix="/notes", tags=["notes"])