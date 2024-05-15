from fastapi import FastAPI

from app import database, sensors_measurements

from app.sensors import models
from app.meteostatins import models
from app.sensors import models
from app.measurements_type import models


from app.sensors import routers as sensor
from app.measurements_type import routers as measurements_type
from app.meteostatins import routers as meteostatins
from app.measurements import routers as measurements
from app.sensors_measurements import routers as sensors_measurements


app = FastAPI()

app.include_router(sensor.router, tags=["Sensors"])
app.include_router(measurements_type.router, tags=["Measurements Type"])
app.include_router(meteostatins.router, tags=["Meteostation Sensors"])
app.include_router(measurements.router, tags=["Measurements"])
app.include_router(sensors_measurements.router, tags=["Sensors_Measurements"])

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)