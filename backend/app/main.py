from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api import ping
from app.db import async_session, metadata, engine


app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@asynccontextmanager
async def lifespan():
    async with engine.begin() as conn:
        await conn.run_sync(metadata.create_all)
    await async_session.connect()
    yield
    await async_session.disconnect()

app.include_router(ping.router, tags=["ping"])
# app.include_router(notes.router, prefix="/notes", tags=["notes"])