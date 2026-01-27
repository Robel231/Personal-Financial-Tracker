# Personal Financial Tracker

A Flutter-based personal financial tracker app built with Clean Architecture principles.

## Architecture

- **Clean Architecture**: Separation of concerns with Domain, Data, and Presentation layers
- **State Management**: Riverpod (annotation-based)
- **Database**: Drift (SQLite)
- **Models**: Freezed for immutable data classes
- **UI**: Material Design 3

## Getting Started

### 1. Install Dependencies

\`\`\`bash
flutter pub get
\`\`\`

### 2. Generate Code

\`\`\`bash
dart run build_runner build --delete-conflicting-outputs
\`\`\`

### 3. Run the App

\`\`\`bash
flutter run
\`\`\`

## Project Structure

\`\`\`
lib/
├── core/                      # Core utilities and constants
├── domain/                    # Business logic layer
│   ├── entities/             # Domain models (Category, Transaction)
│   └── repositories/         # Repository interfaces
├── data/                      # Data layer
│   ├── database/             # Drift database & tables
│   └── repositories/         # Repository implementations
└── presentation/              # UI layer
    ├── providers/            # Riverpod providers
    └── screens/              # UI screens
\`\`\`

## Features

- ✅ Track income and expenses
- ✅ Categorize transactions
- ✅ View financial summary (balance, income, expense)
- ✅ Material Design 3 UI
- 🚧 Add/Edit transactions (coming soon)
- 🚧 Category management (coming soon)
- 🚧 Charts and analytics (coming soon)
