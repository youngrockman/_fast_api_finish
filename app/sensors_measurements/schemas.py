from pydantic import BaseModel
from typing import List, Optional

class SensorMeasurement(BaseModel):
    type_id: int
    type_formula: Optional[str] = None

class SensorMeasurementsCreate(BaseModel):
    sensors_measurements: List[SensorMeasurement]

class Message(BaseModel):
    message: str

class MeasurementTypeList(BaseModel):
    measurements_type: List[int]
