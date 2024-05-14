from sqlalchemy.orm import Session
from app.measurements_type import models, schemas

def create_measurement_type(db: Session, measurement_type: schemas.MeasurementTypeCreate):
    db_measurement_type = models.MeasurementType(**measurement_type.dict())
    db.add(db_measurement_type)
    db.commit()
    db.refresh(db_measurement_type)
    return db_measurement_type

def get_measurement_types(db: Session):
    return db.query(models.MeasurementType).all()

def get_measurement_type(db: Session, type_id: int):
    return db.query(models.MeasurementType).filter(models.MeasurementType.type_id == type_id).first()

def update_measurement_type(db: Session, type_id: int, measurement_type: schemas.MeasurementTypeUpdate):
    db_type = db.query(models.MeasurementType).filter(models.MeasurementType.type_id == type_id).first()
    if db_type:
        db_type.type_name = measurement_type.type_name
        db_type.type_units = measurement_type.type_units
        db.commit()
        return db_type

def delete_measurement_type(db: Session, type_id: int):
    db_type = db.query(models.MeasurementType).filter(models.MeasurementType.type_id == type_id).first()
    if db_type:
        db.delete(db_type)
        db.commit()
        return True
    return False
