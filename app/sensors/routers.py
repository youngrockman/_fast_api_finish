
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.sensors import crud, schemas
from app import database
from app.exceptions import DetailedHTTPException

tags_metadata = [
    {
        "name": "Sensors",
        "description": "CRUD operations for interacting with table sensors",
        "externalDocs": {
            "description": "Find out more about working with sensors",
            "url": "https://yourdocumentationlink.com/sensors",
        },
    },
]














router = APIRouter()

@router.post("/sensors/", response_model=schemas.Sensor)
def create_sensor(sensor: schemas.SensorCreate, db: Session = Depends(database.get_db)):
    # return crud.create_sensor(db=db, sensor=sensor)
    try:
        return crud.create_sensor(db=db, sensor=sensor)
    except Exception as e:  # Замените Exception на специфические исключения, если это возможно
        raise DetailedHTTPException()

@router.get("/sensors/", response_model=List[schemas.Sensor])
def read_sensors(skip: int = 0, limit: int = 100, db: Session = Depends(database.get_db)):
    # sensors = crud.get_sensors(db, skip=skip, limit=limit)
    # return sensors
    try:
        sensors = crud.get_sensors(db, skip=skip, limit=limit)
        return sensors
    except Exception as e:
        raise DetailedHTTPException()

@router.get("/sensors/{sensor_id}", response_model=schemas.Sensor)
def read_sensor(sensor_id: int, db: Session = Depends(database.get_db)):
    db_sensor = crud.get_sensor(db, sensor_id)
    if db_sensor is None:
        raise HTTPException(status_code=404, detail="Sensor not found")
    return db_sensor

@router.put("/sensors/{sensor_id}", response_model=schemas.Sensor)
def update_sensor(sensor_id: int, sensor: schemas.SensorCreate, db: Session = Depends(database.get_db)):
    updated_sensor = crud.update_sensor(db=db, sensor_id=sensor_id, sensor=sensor)
    if updated_sensor is None:
        raise HTTPException(status_code=404, detail="Sensor not found")
    return updated_sensor

@router.delete("/sensors/{sensor_id}")
def delete_sensor(sensor_id: int, db: Session = Depends(database.get_db)):
    if not crud.delete_sensor(db=db, sensor_id=sensor_id):
        raise HTTPException(status_code=404, detail="Sensor not found")
    return {"message": "Sensor deleted successfully"}
