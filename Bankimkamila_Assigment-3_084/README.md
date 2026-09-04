# Library Management System - Dart Console App

A console-based Library Management System built using Dart demonstrating Object-Oriented Programming (OOP) concepts, collection manipulation, data encapsulation, and interactive CLI handling.

---

## 🚀 How to Run

### Prerequisites
- Dart SDK (v3.0 or higher recommended) - [Get Dart](https://dart.dev/get-dart)

### Run Locally
```bash
# Run using Dart SDK
dart run library_system.dart
```

### Online Execution
You can also copy and paste the contents of `library_system.dart` into [DartPad](https://dartpad.dev/).

---

## 📚 Features

1. **View All Books**: Displays full list of books with IDs, authors, titles, publication years, and status.
2. **View Available Books**: Filters and shows only books available to borrow.
3. **View Borrowed Books**: Filters and shows currently borrowed books.
4. **Add a New Book**: Add books with unique ID validation and year validation.
5. **Borrow a Book**: Mark an available book as borrowed by ID.
6. **Return a Book**: Return a borrowed book by ID to make it available again.
7. **Search Books by Title**: Case-insensitive substring search across all titles.
8. **View Library Statistics**: Total count, available count, borrowed count, and live availability percentage.
9. **Exit Application**: Clean exit.

---

## 🧠 OOP Concepts Used

| Concept | Implementation in Code |
| :--- | :--- |
| **Abstraction** | `abstract class LibraryItem` defines the contract (`borrowItem()`, `returnItem()`, `displayInfo()`). |
| **Inheritance** | `class Book extends LibraryItem` inherits members and structure. |
| **Encapsulation** | Private fields (`_id`, `_title`, `_author`, `_year`, `_isAvailable`) with getters and validation in setters. |
| **Polymorphism & Overriding** | `@override` implementations for `borrowItem()`, `returnItem()`, and `displayInfo()`. |
| **Constructors** | Parameterized constructor with optional positional parameter for availability default (`Book(...)`). |
| **Collections & High-Order Functions** | `List<Book>`, `.where()`, `.any()`, `.map()`, and string manipulation for searching and filtering. |

---

## 📋 Menu Preview

```text
============================================================
📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚
============================================================
------------------------------------------------------------
📋 MAIN MENU
------------------------------------------------------------
1. 📚 View All Books
2. ✅ View Available Books
3. ❌ View Borrowed Books
4. ➕ Add a New Book
5. 📖 Borrow a Book
6. ↩️  Return a Book
7. 🔍 Search Books by Title
8. 📊 View Library Statistics
9. 🚪 Exit
------------------------------------------------------------
```
