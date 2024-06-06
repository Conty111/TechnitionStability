from app.services.executor import TechnitionStability
from app.services.crud.models import info_system_crud
from app.entieties.models.infosystem import InfoSystemModel
from app.entieties.schema.infosystem import InfoSystem, InfoSystemCreate
from app.db import get_db

from uuid import UUID
from typing import List

from fastapi import APIRouter, HTTPException, Request, Response, Path, Depends
from sqlalchemy.ext.asyncio import AsyncSession

router = APIRouter()

@router.post("/{id}/calculate")
async def calculate_tech_stability(id: str = Path(...), db: AsyncSession = Depends(get_db)):
    try:
        print(id)
        id = UUID(id)
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid UUID")

    info_system = await info_system_crud.get(db=db, id=id)
    if info_system is None:
        raise HTTPException(status_code=404, detail="InfoSystem not found")

    stability = TechnitionStability(id)
    await stability.set_virtual_machines(db=db)
    await stability.set_software_stability(db=db)
    await stability.set_hardware_stability(db=db)

    db.add(stability.hardware_stability)
    db.add(stability.software_stability)

    await db.commit()

    return Response(status_code=201)

@router.get("/")
async def info_systems(skip: int = 0, limit: int = 10, db: AsyncSession = Depends(get_db)):
    info_systems: List[InfoSystemModel] = await info_system_crud.get_multi(db=db, skip=skip, limit=limit)
    return [InfoSystem.model_validate(info_system).model_dump() for info_system in info_systems]

@router.post("/create")
async def info_systems(request: Request, db: AsyncSession = Depends(get_db)):
    try:
        body = await request.json()
        obj_in = InfoSystemCreate(**body)
        await info_system_crud.create(db=db, obj_in=obj_in)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail=str(e))
    return Response(status_code=201)