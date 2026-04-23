# Field Force Management System - Task & Visit Tracking

## 👋 Overview
Hi there! This is my submission for the Flutter App Developer assignment. After reviewing the requirements, I decided to build **Option 1: Field Task & Visit Tracking Mobile App**.

My primary goal was to showcase a clean Flutter architecture, practical mobile flows, and a permission-aware UI. Since the instructions emphasized focusing on the Flutter application rather than backend complexity, I built a robust in-memory mocked data layer. This guarantees the app is 100% demo-ready the moment you open it, without relying on any paid services or requiring complex backend setup steps.

## 🏗️ Architecture & State Management
To keep the codebase maintainable and production-ready, I used a **feature-first folder structure**. This cleanly separates the UI, state, and data layers. 

For state management, I utilized **GetX**. It allowed me to rapidly build a highly reactive UI with clean handling of loading, empty, and error states. It also made dependency injection straightforward for our mock services. While I used GetX here for development speed and clean routing, I am highly adaptable and perfectly comfortable transitioning to Riverpod or Provider if that is the team's standard.

## 🤖 Mock AI Integration
The AI feature is implemented strictly as a mocked module, exactly as requested. I created a dedicated `MockAiService` abstraction. When a field agent submits visit notes, the service uses deterministic logic (keyword scanning) to instantly generate one of the following outputs:
* A warning flag (e.g., if the note mentions an "issue")
* A suggested next step
* A routine summary

Because the logic is decoupled into its own service layer, it is structured perfectly so it can later be replaced by a real LLM endpoint in production.

## 🔐 Demo Credentials & Roles
The app features dynamic UI rendering based on the logged-in user's role and scope. You can log in using any of the seeded dummy accounts below to test the core flows. 

*Tip: I highly recommend logging in as **Dave Agent** first to test the Visit Form and Mock AI output!*

| Role | Login Name (Type exactly as shown) | Module Visibility |
| :--- | :--- | :--- |
| **Field Agent** | `Dave Agent` | My Tasks, Log Visit, Activity History |
| **Admin** | `Alice Admin` | All Tasks, Activity History |
| **Regional Manager**| `Bob Manager` | All Tasks, Activity History |
| **Team Lead** | `Charlie Lead` | All Tasks, Activity History |
| **Auditor** | `Eve Auditor` | All Tasks, Activity History |

## 🚀 Setup & Run Instructions

Since the data layer is mocked locally, running the app is incredibly easy.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rishabhaiml/field_task_and_visit_tracking.git
   cd field_task_and_visit_tracking
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the application:**
   ```bash
   flutter run
   ```

To quickly review the app without running the code, I have also included a testable Android APK in the repository releases.

### 📥 Quick Test (APK Download)
To quickly review the app without running the code, I have included a testable Android APK in the repository releases. You can download it directly here:
* [Download FieldForceApp-Release.apk (v1.0.0)](https://github.com/rishabhaiml/field_task_and_visit_tracking/releases/tag/v1.0.0)
```


## 📝 Assumptions & Trade-offs
* **Authentication:** To make testing seamless, I bypassed passwords. The app simply checks the typed name against the local database to assign the correct role.
* **Data Persistence:** Data is stored in memory. Restarting the app will refresh the database back to its seeded dummy state.
* **Network Simulation:** I intentionally added small `Future.delayed` artificial delays in the mock services so you can see the UI loading states in action.

Thank you for taking the time to review my code. I am looking forward to discussing the design decisions with the team!