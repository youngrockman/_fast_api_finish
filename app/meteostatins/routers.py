from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.meteostatins import crud, schemas
from ..database import get_db


tags_metadata = [
    {
        "name": "Meteostations",
        "description": "Operations related to meteostations. Allows managing meteostations, including creating, reading, updating, and deleting meteostations, as well as managing sensors associated with them.",
        "externalDocs": {
            "description": "Find out more about working with meteostations",
            "url": "https://yourdocumentationlink.com/meteostations",
        },
    },
]









router = APIRouter()

@router.post("/meteostatins/", response_model=schemas.Meteostatin)
def create_meteostatin(meteostatin: schemas.MeteostatinCreate, db: Session = Depends(get_db)):
    return crud.create_meteostatin(db=db, meteostatin=meteostatin)

@router.get("/meteostatins/", response_model=List[schemas.Meteostatin])
def read_meteostatins(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    meteostatins = crud.get_meteostatins(db, skip=skip, limit=limit)
    return meteostatins

@router.get("/meteostatins/{station_id}", response_model=schemas.Meteostatin)
def read_meteostatin(station_id: int, db: Session = Depends(get_db)):
    db_meteostatin = crud.get_meteostatin(db, station_id=station_id)
    if db_meteostatin is None:
        raise HTTPException(status_code=404, detail="Meteostatin not found")
    return db_meteostatin

@router.delete("/meteostatins/{station_id}", response_model=dict)
def delete_meteostatin(station_id: int, db: Session = Depends(get_db)):
    if not crud.delete_meteostatin(db=db, station_id=station_id):
        raise HTTPException(status_code=404, detail="Meteostatin not found")
    return {"msg": "Meteostatin deleted successfully"}


@router.post("/meteostations/{station_id}/sensors/", response_model=schemas.MeteostationSensor)
def create_sensor_for_meteostation(station_id: int, sensor_data: schemas.MeteostationSensorCreate, db: Session = Depends(get_db)):
    return crud.create_meteostation_sensor(db=db, station_id=station_id, sensor_data=sensor_data)

@router.delete("/meteostations/sensors/{sensor_inventory_number}", response_model=dict)
def delete_sensor_from_meteostation(sensor_inventory_number: str, db: Session = Depends(get_db)):
    if not crud.delete_meteostation_sensor(db=db, sensor_inventory_number=sensor_inventory_number):
        raise HTTPException(status_code=404, detail="MeteostationSensor not found")
    return {"msg": "MeteostationSensor deleted successfully"}

@router.get("/meteostations/{station_id}/sensors/", response_model=List[schemas.MeteostationSensor])
def get_sensors_for_meteostation(station_id: int, db: Session = Depends(get_db)):
    sensors = crud.get_meteostation_sensors(db, station_id=station_id)
    if sensors is None:
        raise HTTPException(status_code=404, detail="No sensors found for this meteostation")
    return sensors

