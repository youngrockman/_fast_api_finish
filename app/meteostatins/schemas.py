from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class MeteostationSensorBase(BaseModel):
    sensor_inventory_number: Optional[str] = None
    sensor_id: int
    added_ts: Optional[datetime] = None
    removed_ts: Optional[datetime] = None

class MeteostationSensorCreate(MeteostationSensorBase):
    pass

class MeteostationSensor(MeteostationSensorBase):
    station_id: int

    class Config:
        orm_mode = True

class MeteostatinBase(BaseModel):
    station_name: str
    station_longitude: float
    station_latitude: float

class MeteostatinCreate(MeteostatinBase):
    pass

class Meteostatin(MeteostatinBase):
    station_id: int
    sensors: List[MeteostationSensor] = []

    class Config:
        orm_mode = True
