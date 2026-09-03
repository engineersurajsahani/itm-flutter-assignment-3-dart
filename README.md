# Library Management System – Dart Console App

A console-based Library Management System built with **Dart**, demonstrating core **OOP concepts** including classes, inheritance, encapsulation, abstraction, polymorphism, method overriding, and mixins.

---

## 📋 Assignment

Course: ITM Flutter / Dart  
Assignment: [Library Management System](https://itm-flutter-assignment-3-dart.netlify.app/)

---

## 🚀 How to Run

### Option 1 – Local Dart SDK

```bash
# 1. Make sure Dart SDK is installed
dart --version

# 2. Navigate to the project folder
cd Dart-programming-assignment-3

# 3. Run the program
dart library_system.dart
```

### Option 2 – DartPad (Online, no install needed)

1. Open [https://dartpad.dev/](https://dartpad.dev/)
2. Copy the full contents of `library_system.dart`
3. Paste into DartPad and click **Run**

---

## ✨ Features

| # | Feature | Description |
|---|---------|-------------|
| 1 | **View All Books** | Lists every book with ID, title, author, year, and status |
| 2 | **View Available Books** | Shows only books ready to borrow |
| 3 | **View Borrowed Books** | Shows only checked-out books |
| 4 | **Add a New Book** | Accepts title, author, year – auto-generates a unique ID |
| 5 | **Borrow a Book** | Marks a book as borrowed (validates availability) |
| 6 | **Return a Book** | Marks a book as available again |
| 7 | **Search Books by Title** | Partial, case-insensitive keyword search |
| 8 | **Library Statistics** | Total, available, borrowed count and availability % |
| 9 | **Exit** | Gracefully exits the application |

---

## 🏗️ OOP Concepts Used

| Concept | Where Applied |
|---------|---------------|
| **Classes & Objects** | `Book`, `Library`, `LibraryApp` |
| **Encapsulation** | Private fields `_id`, `_title`, `_author`, `_year`, `_isAvailable` with getters/setters |
| **Abstract Class** | `LibraryItem` declares `borrowItem()`, `returnItem()`, `displayInfo()` |
| **Inheritance** | `Book extends LibraryItem` |
| **Method Overriding** | `Book` overrides all three abstract methods |
| **Runtime Polymorphism** | `Library` calls `book.borrowItem()` / `book.returnItem()` via base type |
| **Constructor** | Named/parameterized constructor with default values in `Book` |
| **Mixin (Interface)** | `Searchable` mixin provides `matchesKeyword()` helper |

---

## 📁 Project Structure

```
Dart-programming-assignment-3/
├── library_system.dart   ← Main source file (all code in one file)
└── README.md             ← This file
```

---

## 📸 Sample Output

```
  ============================================================
  📚  WELCOME TO THE LIBRARY MANAGEMENT SYSTEM  📚
  ============================================================

  ------------------------------------------------------------
  📋  MAIN MENU
  ------------------------------------------------------------
  1. 📚  View All Books
  2. ✅  View Available Books
  3. ❌  View Borrowed Books
  4. ➕  Add a New Book
  5. 📖  Borrow a Book
  6. ↩️   Return a Book
  7. 🔍  Search Books by Title
  8. 📊  View Library Statistics
  9. 🚪  Exit
  ------------------------------------------------------------

  Enter your choice (1-9): 1

  ------------------------------------------------------------
  VIEW ALL BOOKS
  ------------------------------------------------------------
  📚 === ALL BOOKS ===
  📚 ID: B001 | Title: The Great Gatsby | Author: F. Scott Fitzgerald | Year: 1925 | Status: ✅ Available
  📚 ID: B002 | Title: 1984 | Author: George Orwell | Year: 1949 | Status: ✅ Available
  📚 ID: B003 | Title: To Kill a Mockingbird | Author: Harper Lee | Year: 1960 | Status: ✅ Available
  📚 ID: B004 | Title: The Alchemist | Author: Paulo Coelho | Year: 1988 | Status: ✅ Available
  📚 ID: B005 | Title: Harry Potter and the Sorcerer's Stone | Author: J.K. Rowling | Year: 1997 | Status: ✅ Available
  📚 ID: B006 | Title: The Da Vinci Code | Author: Dan Brown | Year: 2003 | Status: ✅ Available

  📊 Total Books: 6  |  ✅ Available: 6  |  ❌ Borrowed: 0
```

---

## 👤 Author

**Adarsh Singh**  
Dart Programming Assignment 3 – Library Management System
