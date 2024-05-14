# src/config.py
from pydantic_settings import BaseSettings
from pydantic import PostgresDsn

# class Settings(BaseSettings):
#     DATABASE_URL: PostgresDsn
#
#     class Config:
#         env_file = "../.env"
#
# settings = Settings()