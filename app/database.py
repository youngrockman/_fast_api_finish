from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import PostgresDsn


# Используем строку подключения из настроек
engine = create_engine(str('postgresql://postgres:123@83.147.247.59:5435/test_apiv2'))
# engine = create_engine(str('postgresql://postgres:555@db:5432/test_apiv2'))
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()




def get_db():
    db: Session = SessionLocal()
    try:
        yield db
    finally:
        db.close()
