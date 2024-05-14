from sqlalchemy.orm import Session
from app.meteostatins import models, schemas
from datetime import datetime


def create_meteostatin(db: Session, meteostatin: schemas.MeteostatinCreate):
    db_item = models.Meteostatin(**meteostatin.dict())
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

def get_meteostatins(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Meteostatin).offset(skip).limit(limit).all()

def get_meteostatin(db: Session, station_id: int):
    return db.query(models.Meteostatin).filter(models.Meteostatin.station_id == station_id).first()

def delete_meteostatin(db: Session, station_id: int):
    db_item = db.query(models.Meteostatin).filter(models.Meteostatin.station_id == station_id).first()
    if db_item is not None:
        db.delete(db_item)
        db.commit()
        return True
    return False


def create_meteostation_sensor(db: Session, station_id: int, sensor_data: schemas.MeteostationSensorCreate):
    db_sensor = models.MeteostationSensor(**sensor_data.dict(), station_id=station_id)
    db.add(db_sensor)
    db.commit()
    db.refresh(db_sensor)
    return db_sensor

def delete_meteostation_sensor(db: Session, sensor_inventory_number: str):
    db_sensor = db.query(models.MeteostationSensor).filter(models.MeteostationSensor.sensor_inventory_number == sensor_inventory_number).first()
    if db_sensor:
        db.delete(db_sensor)
        db.commit()
        return True
    return False

def get_meteostation_sensors(db: Session, station_id: int):
    return db.query(models.MeteostationSensor).filter(models.MeteostationSensor.station_id == station_id).all()

