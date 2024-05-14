from pydantic import BaseModel
from datetime import datetime

class MeasurementCreate(BaseModel):
    sensor_inventory_number: str
    measurement_value: float
    measurement_ts: datetime
    measurement_type: int

class Measurement(BaseModel):
    sensor_inventory_number: str
    measurement_value: float
    measurement_ts: datetime
    measurement_type: int

    class Config:
        orm_mode = True

