from fastapi import FastAPI

from app import database

from app.sensors import models
from app.meteostatins import models
from app.sensors import models
from app.measurements_type import models


from app.sensors import routers as sensor
from app.measurements_type import routers as measurements_type
from app.meteostatins import routers as meteostatins
from app.measurements import routers as measurements
from app.sensors.routers import tags_metadata as Sen
from app.measurements_type.routers import tags_metadata as Mea_type
from app.meteostatins.routers import tags_metadata as Meteost
from app.measurements.routers import tags_metadata as Measurem

description = """
Fast API for for observing and measuring weather conditions using weather stations and its sensors

## Meteostations

Interaction with weather stations

* **Create meteostations**
* **Read meteostations**
* **Update meteostations**
* **Delete meteostations**

## Sensors

Interaction with sensors

* **Add sensors to meteostations**
* **Viewing sensors of meteostations**
* **Update sensor details**
* **Delete sensors from meteostations**

## Measurements

Working with received sensor measurements

* **Add new measurements**
* **Viewing measurements**
* **Delete measurements**


## Measurements Type

Sensor Operations
* **Define new measurements types**
* **Viewing available measurements types**
* **Update existing measurements types**
* **Delete unused measurements types**
"""


tags_metadata = Sen + Mea_type + Meteost + Measurem
app = FastAPI(
    title="Application for managing Stations with sensors",
    description=description,
    version="1.100",
    terms_of_service="https://example.com/terms/",
    contact={
        "name": "Admin",
        "url": "https://weatherstation.example.com/contact/",
        "email": "email@station.example.com",
    },
    license_info={
        "name": "AS",
        "url": "https://opensource.org/licenses/AS",
    },
    openapi_tags=tags_metadata
)




models.Base.metadata.create_all(bind=database.engine)

app.include_router(sensor.router, tags=["Sensors"])
app.include_router(measurements_type.router, tags=["Measurements Type"])
app.include_router(meteostatins.router, tags=["Meteostation Sensors"])
app.include_router(measurements.router, tags=["Measurements"])

# Запуск сервера FastAPI (при необходимости)
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)