import uuid

from fastapi import FastAPI, UploadFile, File
from ultralytics import YOLO
import numpy as np
import cv2
from io import BytesIO
import shutil

app = FastAPI()


model = None   # Do not charge it here


@app.on_event("startup")
def load_model():
    global model
    model = YOLO("yolo11n.pt")   # <- It is loaded after the server is up


@app.get("/health", status_code=200)
async def get_health() -> dict:
    return {
        "status": "model_loaded",
    }


@app.post("/predict/", status_code=200)
async def post_predict(file: UploadFile = File(...)) -> dict:
    # Save uploaded file
    file_id = str(uuid.uuid4())
    file_path = f"upload_{file_id}.jpg"

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Run YOLO prediction
    results = model.predict(file_path)

    # YOLO result object
    detections = []
    for r in results:
        for box in r.boxes:
            detections.append({
                "class": model.names[int(box.cls)],
                "confidence": float(box.conf),
                "bbox": box.xyxy.tolist()[0]  # [x1, y1, x2, y2]
            })

    return {
        "file_id": file_id,
        "detections": detections
    }
