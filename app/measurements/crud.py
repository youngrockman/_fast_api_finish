from typing import List, Optional

from sqlalchemy.orm import Session
from app.measurements import models, schemas

def create_measurement(db: Session, measurement: schemas.MeasurementCreate):
    db_measurement = models.Measurement(**measurement.dict())
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


# def get_measurements_by_conditions(db: Session, station_id: Optional[int] = None, sensor_id: Optional[int] = None):
#     query = db.query(models.Measurement)
#     if station_id:
#         query = query.join(models.MeteostationSensor).filter(models.MeteostationSensor.station_id == station_id)
#     if sensor_id:
#         query = query.filter(models.MeteostationSensor.sensor_id == sensor_id)
#     return query.all()
