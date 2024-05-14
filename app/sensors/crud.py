from sqlalchemy.orm import Session
from app.sensors import schemas, models
from app.measurements_type.models import MeasurementType


def create_sensor(db: Session, sensor: schemas.SensorCreate):
    db_sensor = models.Sensor(sensor_name=sensor.sensor_name)
    db.add(db_sensor)
    db.commit()
    db.refresh(db_sensor)
    for measurement in sensor.sensors_measurements:
        db_measurement = models.SensorMeasurement(**measurement.dict(), sensor_id=db_sensor.sensor_id)
        db.add(db_measurement)
    db.commit()
    return db_sensor


def get_sensors(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Sensor).offset(skip).limit(limit).all()


# def get_sensor(db: Session, sensor_id: int):
#     return db.query(models.Sensor).filter(models.Sensor.sensor_id == sensor_id).first()


def get_sensor(db: Session, sensor_id: int):
    sensor = db.query(models.Sensor).filter(models.Sensor.sensor_id == sensor_id).first()
    if sensor:
        # Fetching measurement types separately and appending them to each measurement
        for measurement in sensor.measurements:
            measurement_type = db.query(MeasurementType).filter(MeasurementType.type_id == measurement.type_id).first()
            measurement.measurement_type = measurement_type  # Assuming this works due to your ORM configuration
    return sensor





def update_sensor(db: Session, sensor_id: int, sensor: schemas.SensorCreate):
    db_sensor = db.query(models.Sensor).filter(models.Sensor.sensor_id == sensor_id).first()
    if db_sensor:
        db_sensor.sensor_name = sensor.sensor_name
        # Handle measurements update logic here
        db.commit()
        return db_sensor
    return None


def delete_sensor(db: Session, sensor_id: int):
    db_sensor = db.query(models.Sensor).filter(models.Sensor.sensor_id == sensor_id).first()
    if db_sensor:
        db.delete(db_sensor)
        db.commit()
        return True
    return False