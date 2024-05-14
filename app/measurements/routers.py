from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.measurements import crud, models, schemas
from ..database import get_db



tags_metadata = [
    {
        "name": "Measurements",
        "description": "Operations with measurements. Allows for adding new measurements, retrieving existing measurements, and deleting measurements.",
        "externalDocs": {
            "description": "Find out more about measurements",
            "url": "https://yourdocumentationlink.com/measurements",
        },
    },
]






router = APIRouter()













@router.post("/measurements/", response_model=schemas.Measurement)
def create_measurement(measurement: schemas.MeasurementCreate, db: Session = Depends(get_db)):
    return crud.create_measurement(db=db, measurement=measurement)

@router.get("/measurements/", response_model=List[schemas.Measurement])
def read_measurements(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    measurements = crud.get_measurements(db, skip=skip, limit=limit)
    return measurements

@router.delete("/measurements/")
def delete_measurements(measurement_ids: List[str], db: Session = Depends(get_db)):
    crud.delete_measurements_by_ids(db=db, measurement_ids=measurement_ids)
    return {"msg": "Measurements deleted successfully"}

# @router.get("/measurements/")
# def read_measurements_by_conditions(station_id: Optional[int] = None, sensor_id: Optional[int] = None, db: Session = Depends(get_db)):
#     measurements = crud.get_measurements_by_conditions(db, station_id=station_id, sensor_id=sensor_id)
#     return measurements

