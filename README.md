# ብሬ (Birre) Financial Tracker

A premium, Clean Architecture-based personal financial tracker tailored for Ethiopian users. Birre helps you manage transactions, set smart budgets, and reach your savings goals (Equb).

## ✨ Key Features

- **📊 Advanced Analytics**: Visualize your spending patterns with interactive Doughnut charts and Weekly trend bar charts (powered by `fl_chart`).
- **🎯 Equb & Savings Goals**: Create multiple savings goals with custom icons and colors. Track your progress with real-time visual progress bars.
- **💰 Smart Budgeting (በጀት)**: Set monthly spending limits for expense categories. Get visual warnings (80% usage) and alerts (100% usage) to keep your finances on track.
- **📩 SMS Automation**: Automatically detect and import transaction messages from CBE, Telebirr, and other financial services.
- **🌍 Localized Experience**: Built with Ethiopian currency formatting and intuitive category icons.
- **🌗 Premium UI**: Modern Material Design 3 interface with smooth animations and a focus on visual excellence.

## 🛠️ Architecture & Tech Stack

- **Framework**: Flutter 3 (Material Design 3)
- **Architecture**: Clean Architecture (Domain, Data, Presentation layers)
- **State Management**: Riverpod (Annotation-based for type-safety)
- **Database**: Drift (SQLite) with safe schema migration (v2+)
- **Charts**: fl_chart (High-performance interactive charts)
- **Models**: Freezed (Immutable classes & Union types)

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the Flutter SDK installed on your machine.

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Generate Code
Generate immutable models and database code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the App
```bash
flutter run
```

## 📂 Project Structure

```
lib/
## Features

- ✅ Track income and expenses
- ✅ Categorize transactions
- ✅ View financial summary (balance, income, expense)
- ✅ Material Design 3 UI
- 🚧 Add/Edit transactions (coming soon)
- 🚧 Category management (coming soon)
- 🚧 Charts and analytics (coming soon)
