# 📱 Contact App (Flutter)

A contact management app built using Flutter with offline database support and clean state management.
To understand the core of state managment i made a simple project to get grasp on how to use offline database with CRUD operations .

---

## 🚀 Features

- Add, update, and delete contacts
- Search contacts by name or number
- Persistent storage using SQLite
- Clean UI with structured state management

---

## 🧠 Tech Stack

- Flutter
- Provider (State Management)
- SQLite (sqflite)

---

## 🏗️ Architecture

UI → Provider → Database

---

## 🎨 UI Iteration & Improvement

After building the core functionality (CRUD operations with Provider and SQLite),
I improved the UI by refining layout and design.

I used AI-assisted prompting to explore better UI structuring,
while keeping the application logic unchanged.

This helped me:
- Improve visual hierarchy
- Refactor UI cleanly
- Maintain separation of concerns
The business logic (Provider + SQLite) remained unchanged, ensuring UI improvements were purely presentational.

### Before vs After

![Before UI](assets/before.png)
![After UI](assets/after.png)
## ⚡ How to Run

```bash
flutter pub get
flutter run