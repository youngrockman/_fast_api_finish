from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from app.measurements_type import crud, schemas  # Импорт database должен быть адаптирован под ваш проект
from app import database



tags_metadata = [ {
    "name": "measurements_type",
    "description": "Operations related to measurements types. Manage the types of measurements that sensors can perform, including creating, listing, updating, and deleting measurements types.",
    "externalDocs": {
        "description": "Learn more about measurements types",
        "url": "https://yourdocumentationlink.com/measurements_type",
    },
}
]









router = APIRouter()

@router.post("/measurement_types/", response_model=schemas.MeasurementType)
def create_measurement_type(measurement_type: schemas.MeasurementTypeCreate, db: Session = Depends(database.get_db)):
    return crud.create_measurement_type(db=db, measurement_type=measurement_type)

@router.get("/measurement_types/", response_model=List[schemas.MeasurementType])
def read_measurement_types(db: Session = Depends(database.get_db)):
    return crud.get_measurement_types(db=db)

@router.get("/measurement_types/{type_id}", response_model=schemas.MeasurementType)
def read_measurement_type(type_id: int, db: Session = Depends(database.get_db)):
    measurement_type = crud.get_measurement_type(db=db, type_id=type_id)
    if not measurement_type:
        raise HTTPException(status_code=404, detail="Measurement type not found")
    return measurement_type

@router.put("/measurement_types/{type_id}", response_model=schemas.MeasurementType)
def update_measurement_type(type_id: int, measurement_type: schemas.MeasurementTypeUpdate, db: Session = Depends(database.get_db)):
    updated_measurement_type = crud.update_measurement_type(db=db, type_id=type_id, measurement_type=measurement_type)
    if not updated_measurement_type:
        raise HTTPException(status_code=404, detail="Measurement type not found")
    return updated_measurement_type

@router.delete("/measurement_types/{type_id}", status_code=204)
def delete_measurement_type(type_id: int, db: Session = Depends(database.get_db)):
    if not crud.delete_measurement_type(db=db, type_id=type_id):
        raise HTTPException(status_code=404, detail="Measurement type not found")
    return {"message": "Measurement type successfully deleted"}
