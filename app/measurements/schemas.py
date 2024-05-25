# app/measurements/schemas.py
from datetime import datetime
from pydantic import BaseModel
from typing import List, Optional

class SensorMeasurement(BaseModel):
    type_id: int
    type_formula: Optional[str] = None

class SensorMeasurementsCreate(BaseModel):
    sensors_measurements: List[SensorMeasurement]

class Message(BaseModel):
    message: str

class Measurement(BaseModel):
    sensor_inventory_number: str
    measurement_value: float
    measurement_ts: datetime
    measurement_type: int

    class Config:
        from_attributes = True  # Замените 'orm_mode = True' на 'from_attributes = True'

class MeasurementCreate(BaseModel):
    sensor_inventory_number: str
    measurement_value: float
    measurement_ts: datetime
    measurement_type: int

    class Config:
        from_attributes = True

class MeasurementTypeList(BaseModel):
    measurements_type: List[int]
