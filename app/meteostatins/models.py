from sqlalchemy import Column, Integer, String, ForeignKey, Numeric, DateTime, func
from sqlalchemy.orm import relationship
from ..database import Base
from app.sensors.models import Sensor

class Meteostatin(Base):
    __tablename__ = 'meteostatins'
    station_id = Column(Integer, primary_key=True, autoincrement=True)
    station_name = Column(String(127))
    station_longitude = Column(Numeric(5, 2))
    station_latitude = Column(Numeric(5, 2))
    sensors = relationship("MeteostationSensor", back_populates="meteostatin")

class MeteostationSensor(Base):
    __tablename__ = 'meteostation_sensor'
    sensor_inventory_number = Column(String(15), primary_key=True)
    station_id = Column(Integer, ForeignKey('meteostatins.station_id'))
    sensor_id = Column(Integer, ForeignKey('sensors.sensor_id'))  # Ensure 'sensors' table is defined somewhere
    added_ts = Column(DateTime, default=func.now())
    removed_ts = Column(DateTime)
    meteostatin = relationship("Meteostatin", back_populates="sensors")
    sensor = relationship("Sensor")  # Ensure 'Sensor' model is defined

    measurements = relationship("Measurement", back_populates="meteostation_sensor")
