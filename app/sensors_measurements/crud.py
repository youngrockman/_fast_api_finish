from sqlalchemy.orm import Session
from app.sensors import models as sensor_models
from app.measurements import models as measurement_models
from . import schemas


def create_measurement(db: Session, measurement: schemas.MeasurementCreate):
    db_measurement = measurement_models.Measurement(**measurement.dict())
    db.add(db_measurement)
    db.commit()
    db.refresh(db_measurement)
    return db_measurement


def get_measurements(db: Session, skip: int = 0, limit: int = 100):
    return db.query(measurement_models.Measurement).offset(skip).limit(limit).all()


def delete_measurements_by_ids(db: Session, measurement_ids: List[str]):
    db.query(measurement_models.Measurement) \
        .filter(measurement_models.Measurement.sensor_inventory_number.in_(measurement_ids)) \
        .delete(synchronize_session='fetch')
    db.commit()


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
