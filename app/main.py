import os
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "Wolrd!", "secret": os.getenv("SECRET_ENV", "Secret not found in environment variables")}
