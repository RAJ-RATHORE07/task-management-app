from fastapi import FastAPI
from app.database import Base, engine
from fastapi.middleware.cors import CORSMiddleware

# ✅ IMPORTANT IMPORT
from app.routes.task_routes import router

app = FastAPI(title="Task Manager API")

# Create DB tables
Base.metadata.create_all(bind=engine)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ USE DIRECT ROUTER IMPORT
app.include_router(router)

@app.get("/")
def root():
    return {"message": "API is running 🚀"}