from datetime import datetime
from typing import List, Optional

from sqlalchemy.orm import Session
from app.measurements import models, schemas
from app.measurements import models as measurement_models

def create_measurement(db: Session, measurement: schemas.MeasurementCreate):
    db_measurement = models.Measurement(
        sensor_inventory_number=measurement.sensor_inventory_number,
        measurement_value=measurement.measurement_value,
        measurement_ts=measurement.measurement_ts,
        measurement_type=measurement.measurement_type
    )
    db.add(db_measurement)
    db.commit()
    db.refresh(db_measurement)
    return db_measurement

def get_measurements(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Measurement).offset(skip).limit(limit).all()

def delete_measurements_by_ids(db: Session, measurement_ids: List[str]):
    db.query(models.Measurement)\
      .filter(models.Measurement.sensor_inventory_number.in_(measurement_ids))\
      .delete(synchronize_session='fetch')
    db.commit()

def bind_measurements_to_sensor(db: Session, sensor_id: int, measurements: schemas.SensorMeasurementsCreate):
    sensor = db.query(models.Sensor).filter(models.Sensor.sensor_id == sensor_id).first()
    if not sensor:
        raise ValueError(f"Sensor with id {sensor_id} does not exist")

    try:
        for sensor_measurement in measurements.sensors_measurements:
            db_measurement = models.Measurement(
                sensor_inventory_number=sensor_id,
                measurement_value=None,  # Если нужно указать значение, замените на корректное
                measurement_ts=datetime.utcnow(),  # Время вставки
                measurement_type=sensor_measurement.type_id
            )
            db.add(db_measurement)
        db.commit()
        return {"message": "Measurements bound to sensor successfully"}
    except Exception as e:
        db.rollback()
        raise e
