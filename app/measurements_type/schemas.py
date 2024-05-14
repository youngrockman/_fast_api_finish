from pydantic import BaseModel
from typing import List, Optional

class MeasurementTypeBase(BaseModel):
    type_name: str
    type_units: str

class MeasurementTypeCreate(MeasurementTypeBase):
    pass

class MeasurementTypeUpdate(MeasurementTypeBase):
    pass

class MeasurementType(MeasurementTypeBase):
    type_id: int

    class Config:
        orm_mode = True
