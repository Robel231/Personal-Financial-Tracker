# Personal Financial Tracker - AI Build Guide

## 1. Project Overview & Rules
**Goal:** Build a free, offline, local-first Financial Tracker for Android using Flutter.
**Philosophy:** Own your data. No subscriptions. Clean Architecture.

### Tech Stack
- **Framework:** Flutter (Dart)
- **Architecture:** Clean Architecture (Presentation, Domain, Data)
- **State Management:** Riverpod (with code generation)
- **Database:** Drift (SQLite abstraction)
- **Data Models:** Freezed & JSON Serializable
- **UI Component:** Material 3
- **Charts:** fl_chart

---

## 2. Architecture Blueprint
We will enforce strict separation of concerns so the AI doesn't write spaghetti code.

### Folder Structure
```text
lib/
├── core/                # Constants, DateFormatters, Theme
├── data/                # The "How" (Database, API, SharedPrefs)
│   ├── database/        # Drift database tables
│   ├── models/          # Data Transfer Objects (DTOs)
│   └── repositories/    # Implementation of Domain Repositories
├── domain/              # The "What" (Business Logic, no Flutter code)
│   ├── entities/        # Pure classes (Transaction, Category)
│   └── repositories/    # Abstract Interfaces
├── presentation/        # The "Show" (UI)
│   ├── providers/       # Riverpod Providers (Logic)
│   ├── screens/         # Full pages (Home, Add, Stats)
│   └── widgets/         # Reusable UI bits
└── main.dart