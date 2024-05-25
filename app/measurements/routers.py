from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.measurements import crud, models, schemas
from ..database import get_db
from app.measurements import crud as measurement_crud
from app.sensors import crud as sensor_crud

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

@router.post("/sensors_measurements/{sensor_id}/", response_model=schemas.Message)
def bind_measurements_to_sensor(sensor_id: int, measurements: schemas.SensorMeasurementsCreate, db: Session = Depends(get_db)):
    try:
        result = crud.bind_measurements_to_sensor(db, sensor_id, measurements)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))