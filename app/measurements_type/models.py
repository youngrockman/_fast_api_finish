from ..database import Base
from sqlalchemy import Column, Integer, String, create_engine, ForeignKey
from sqlalchemy.orm import declarative_base, relationship
from app.sensors.models import SensorMeasurement





class MeasurementType(Base):
    __tablename__ = 'measurements_type'
    type_id = Column(Integer, primary_key=True)
    type_name = Column(String(31))
    type_units = Column(String(4))
    sensor_measurements = relationship('SensorMeasurement')

    measurements = relationship("Measurement", back_populates="measurement_type_rel")