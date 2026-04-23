

---

# 📱 Field Force Management System

## Task & Visit Tracking

---

## 👋 Overview

Hi there! This is my submission for the Flutter App Developer assignment. After reviewing the requirements, I decided to build:

> **Option 1: Field Task & Visit Tracking Mobile App**

My primary goal was to showcase:

* Clean Flutter architecture
* Practical mobile flows
* Permission-aware UI

Since the instructions emphasized focusing on the Flutter application rather than backend complexity, I built a **robust in-memory mocked data layer**.

This ensures the app is:

* ✅ 100% demo-ready instantly
* ❌ No paid services required
* ❌ No backend setup needed

---

## 🏗️ Architecture & State Management

To keep the codebase **maintainable and production-ready**, I used a:

> **Feature-first folder structure**

This cleanly separates:

* UI layer
* State layer
* Data layer

### ⚡ State Management

I used **GetX**, which enabled:

* Highly reactive UI
* Clean handling of:

  * Loading states
  * Empty states
  * Error states
* Simple dependency injection for mock services

> While GetX was chosen for speed and clarity, I am fully comfortable transitioning to **Riverpod** or **Provider** based on team standards.

---

## 🤖 Mock AI Integration

The AI feature is implemented as a **mocked module**, exactly as requested.

### 🧠 Implementation Details

I created a dedicated:

> `MockAiService`

When a field agent submits visit notes, the service uses **deterministic logic (keyword scanning)** to generate:

* ⚠️ Warning flag (e.g., if note contains "issue")
* 💡 Suggested next step
* 📄 Routine summary

### 🔌 Design Advantage

Because this logic is:

* Fully decoupled
* Encapsulated in a service layer

➡️ It can be easily replaced with a real **LLM API** in production.

---

## 🔐 Demo Credentials & Roles

The app features **dynamic UI rendering** based on user roles and scope.

> 💡 Tip: Start with **Dave Agent** to test Visit Form + Mock AI output

### 👥 Available Test Users

| Role                 | Login Name (Type exactly as shown) | Module Visibility                     |
| -------------------- | ---------------------------------- | ------------------------------------- |
| **Field Agent**      | `Dave Agent`                       | My Tasks, Log Visit, Activity History |
| **Admin**            | `Alice Admin`                      | All Tasks, Activity History           |
| **Regional Manager** | `Bob Manager`                      | All Tasks, Activity History           |
| **Team Lead**        | `Charlie Lead`                     | All Tasks, Activity History           |
| **Auditor**          | `Eve Auditor`                      | All Tasks, Activity History           |

---

## 🚀 Setup & Run Instructions

Since the data layer is mocked locally, setup is **quick and frictionless**.

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/rishabhaiml/field_task_and_visit_tracking.git
cd field_task_and_visit_tracking
```

### 2️⃣ Install Dependencies

```bash
flutter pub get
```

### 3️⃣ Run the Application

```bash
flutter run
```

---

## 📥 Quick Test (APK Download)

To review the app without running the code, download the APK:

👉 [Download FieldForceApp-Release.apk (v1.0.0)](https://github.com/rishabhaiml/field_task_and_visit_tracking/releases/tag/v1.0.0)

---

## 📝 Assumptions & Trade-offs

### 🔑 Authentication

* Passwords are intentionally bypassed
* Login is based on matching typed name with local database
* Enables **fast and frictionless testing**

### 💾 Data Persistence

* Data is stored **in-memory**
* Restarting the app resets it to seeded dummy state

### 🌐 Network Simulation

* Added `Future.delayed` to mock services
* Allows proper visualization of:

  * Loading states
  * UI transitions

---

## 🙏 Closing Note

Thank you for taking the time to review my code.

I look forward to discussing:

* Design decisions
* Architectural choices
* Possible improvements

---
