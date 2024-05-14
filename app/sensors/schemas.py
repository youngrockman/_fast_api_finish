from pydantic import BaseModel
from typing import List, Optional

class SensorMeasurementCreate(BaseModel):
    type_id: int
    measurement_formula: Optional[str] = None

class SensorCreate(BaseModel):
    sensor_name: str
    sensors_measurements: List[SensorMeasurementCreate] = []

class SensorMeasurement(BaseModel):
    type_id: int
    measurement_formula: Optional[str] = None

    class Config:
        orm_mode = True

class Sensor(BaseModel):
    sensor_id: int
    sensor_name: str
    sensors_measurements: List[SensorMeasurement] = []

    class Config:
        orm_mode = True




class MeasurementTypeBase(BaseModel):
    type_id: int
    type_name: str
    type_units: str

class SensorMeasurement(BaseModel):
    type_id: int
    measurement_formula: Optional[str] = None
    measurement_type: MeasurementTypeBase  # Include this

    class Config:
        orm_mode = True