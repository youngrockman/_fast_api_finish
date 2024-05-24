from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.sensors import crud as sensor_crud, models as sensor_models
from app.measurements import crud as measurement_crud
from . import schemas
from ..database import get_db



router = APIRouter()


@router.post("/sensors_measurements/{sensor_id}/", response_model=schemas.Message)
def bind_measurements_to_sensor(sensor_id: int, measurements: schemas.SensorMeasurementsCreate, db: Session = Depends(get_db)):
    sensor = sensor_crud.get_sensor(db=db, sensor_id=sensor_id)
    if not sensor:
        raise HTTPException(status_code=404, detail="Sensor not found")
    try:
        result = measurement_crud.bind_measurements_to_sensor(db=db, sensor_id=sensor_id, measurements=measurements)
        return {"message": "Measurements bound to sensor successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.delete("/sensors_measurements/{sensor_id}/", response_model=schemas.Message)
def delete_sensor_measurements(sensor_id: int, measurements_type: schemas.MeasurementTypeList, db: Session = Depends(get_db)):
    sensor = sensor_crud.get_sensor(db=db, sensor_id=sensor_id)
    if not sensor:
        raise HTTPException(status_code=404, detail="Sensor not found")
    try:
        result = measurement_crud.delete_sensor_measurements(db=db, sensor_id=sensor_id, measurements_type=measurements_type.measurements_type)
        return {"message": "Measurements deleted successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/measurements/", response_model=List[schemas.Measurement])
def read_measurements(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return measurement_crud.get_measurements(db, skip=skip, limit=limit)
