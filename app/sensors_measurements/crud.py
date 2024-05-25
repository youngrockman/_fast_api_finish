from typing import List
from sqlalchemy.orm import Session
from app.measurements import models as measurement_models
from . import schemas
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def create_measurement(db: Session, measurement: schemas.Measurement):
    db_measurement = measurement_models.Measurement(**measurement.dict())
    db.add(db_measurement)
    db.commit()
    db.refresh(db_measurement)
    return db_measurement


def delete_measurements_by_ids(db: Session, measurement_ids: List[str]):
    db.query(measurement_models.Measurement) \
        .filter(measurement_models.Measurement.sensor_inventory_number.in_(measurement_ids)) \
        .delete(synchronize_session='fetch')
    db.commit()

def delete_sensor_measurements(db: Session, sensor_id: int, measurements_type: list):
    try:
        db.query(measurement_models.Measurement).filter(
            measurement_models.Measurement.sensor_inventory_number == str(sensor_id),
            measurement_models.Measurement.measurement_type.in_(measurements_type)
        ).delete(synchronize_session=False)
        db.commit()
        return {"message": "Measurements deleted successfully"}
    except Exception as e:
        db.rollback()
        raise e

def bind_measurements_to_sensor(db: Session, sensor_id: int, measurements: schemas.SensorMeasurementsCreate):
    try:
        for sensor_measurement in measurements.sensors_measurements:
            db_measurement = measurement_models.Measurement(
                sensor_inventory_number=str(sensor_id),
                measurement_value=None,
                measurement_ts=None,
                measurement_type=sensor_measurement.type_id
            )
            db.add(db_measurement)
        db.commit()
        return {"message": "Measurements bound to sensor successfully"}
    except Exception as e:
        db.rollback()
        raise e
