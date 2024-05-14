from sqlalchemy import Column, Integer, String, ForeignKey, Numeric, DateTime
from sqlalchemy.orm import relationship
from ..database import Base
from app.meteostatins.models import MeteostationSensor
from app.measurements_type.models import MeasurementType
from app.sensors.models import Sensor

class Measurement(Base):
    __tablename__ = 'measurements'
    sensor_inventory_number = Column(String, ForeignKey('meteostation_sensor.sensor_inventory_number'), primary_key=True)
    measurement_value = Column(Numeric(17, 2))
    measurement_ts = Column(DateTime, primary_key=True)
    measurement_type = Column(Integer, ForeignKey('measurements_type.type_id'))

    meteostation_sensor = relationship("MeteostationSensor", back_populates="measurements")
    measurement_type_rel = relationship("MeasurementType", back_populates="measurements")
