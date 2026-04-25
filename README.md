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
<h3>Before vs After</h3>

<p align="center">
  <img src="https://github.com/ADITYA8405/Contact-App/blob/4f4b7c1ae76e136016e28437a07d5c1ccc728e90/assets/%20before.png" height="210" style="margin-right:20px;" />
   &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/ADITYA8405/Contact-App/blob/4f4b7c1ae76e136016e28437a07d5c1ccc728e90/assets/after.png" height="210"/>
</p>

## ⚡ How to Run

```bash
flutter pub get
flutter run