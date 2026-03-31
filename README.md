# 🚀 Task Management App (Flutter + FastAPI)

## 📌 Overview
This is a full-stack Task Management application built using **Flutter (Frontend)** and **FastAPI (Backend)**.  
It allows users to manage tasks with dependencies, search, filtering, and a clean UI.

---

## 🧱 Tech Stack

### Frontend
- Flutter
- Dart
- Provider (State Management)

### Backend
- FastAPI
- Python
- PostgreSQL

---

## 🎯 Features

### ✅ Core Features
- Create, Read, Update, Delete tasks
- Task fields:
  - Title
  - Description
  - Due Date
  - Status (To-Do, In Progress, Done)
  - Blocked By (dependency)

---

### 🎨 UI Features
- Clean and modern UI
- Color-coded task statuses:
  - 🔵 To-Do
  - 🟠 In Progress
  - 🟢 Done
- Blocked tasks are greyed out
- Strike-through for completed tasks

---

### 🔍 Search & Filter
- Search tasks by title
- Filter tasks by status

---

### 💾 Draft Feature
- Form data persists if user leaves screen
- Implemented using SharedPreferences

---

### ⏳ Loading State
- 2-second simulated delay for create/update
- UI remains responsive
- Prevents duplicate submissions

---

## 🚀 Stretch Feature

### Debounced Search
- Search input is debounced (300ms)
- Improves performance and UX

---

## 🔗 API Endpoints

| Method | Endpoint | Description |
|--------|---------|------------|
| GET | /tasks | Fetch tasks |
| POST | /tasks | Create task |
| PUT | /tasks/{id} | Update task |
| DELETE | /tasks/{id} | Delete task |

---

## ⚙️ Setup Instructions

### 🔹 Backend

```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
