# 📚 Library Management System - Dart Console Application

[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![OOP](https://img.shields.io/badge/OOP-Collections%20%26%20Classes-green?style=for-the-badge)](./)

> **Assignment 3**: Console App online / CLI - Collection & OOP Practice  
> **Language**: Dart (SDK 3+)  
> **Domain**: Object-Oriented Programming (OOP) & Collections  

---

### 📌 Student Details
- **Student Name:** Amitabh Morey
- **Roll Number / Enrollment ID:** 150096724064
- **GitHub Profile:** [@AmitabhMorey](https://github.com/AmitabhMorey)

---

## 📖 Project Overview

The **Library Management System** is a robust console-based CLI application built in Dart. It simulates a real-world library inventory and borrowing workflow, allowing users to manage library books, track borrowing status, search the catalog, and view real-time statistics.

---

## 🚀 How to Run

### Prerequisites
- [Dart SDK](https://dart.dev/get-dart) installed (v3.0 or higher recommended)
- Or run in [DartPad](https://dartpad.dev/)

### Running Locally
1. Open terminal and navigate to the project directory:
   ```bash
   cd 150096724064_Amitabh_Morey
   ```
2. Run the application:
   ```bash
   dart library_system.dart
   ```
3. (Optional) Run Dart static analysis:
   ```bash
   dart analyze library_system.dart
   ```

---

## ✨ Features

1. **📚 View All Books**: Lists all books in the catalog with complete details (ID, Title, Author, Year, Status) along with summary counts.
2. **✅ View Available Books**: Filtered listing displaying only books ready for borrowing.
3. **❌ View Borrowed Books**: Filtered listing displaying only books currently checked out.
4. **➕ Add a New Book**: Add new catalog entries with custom IDs, title, author, and year with full input validation.
5. **📖 Borrow a Book**: Check out an available book by entering its ID. Validates availability and updates tracking metadata.
6. **↩️ Return a Book**: Return a checked-out book by ID. Validates borrowing state and restores availability.
7. **🔍 Search Books by Title**: Fast case-insensitive substring search across the library collection.
8. **📊 Library Statistics**: Real-time statistics including total books, available books, borrowed books, and availability percentage.
9. **🚪 Exit**: Graceful shutdown banner.

---

## 🧩 OOP Concepts Checklist & Implementation

| OOP Concept | Implementation in Code |
| :--- | :--- |
| **Classes & Objects** | `Book`, `Library`, and `LibraryApp` model real-world domain entities. |
| **Encapsulation** | Private fields in `Book` (`_id`, `_title`, `_author`, `_year`, `_isAvailable`) accessed and mutated via safe getters and setters with validation rules. |
| **Abstraction** | `LibraryItem` abstract base class defining the contract (`borrowItem()`, `returnItem()`, `displayInfo()`). |
| **Inheritance** | `Book` class extends `LibraryItem` (`class Book extends LibraryItem`). |
| **Method Overriding** | `Book` overrides `borrowItem()`, `returnItem()`, `displayInfo()`, and `toString()`. |
| **Polymorphism** | Runtime polymorphic invocation of `displayInfo()`, `borrowItem()`, and `returnItem()`. |
| **Constructors** | Parameterized constructor `Book(...)` and Factory constructor `Book.create(...)` with validation logic. |
| **Mixins / Interface** | `Trackable` mixin providing timestamp and audit metadata tracking (`recordAdded()`, `recordModified()`, `trackingInfo`). |
| **Collections & Generics** | `List<Book>`, `Map<String, dynamic>`, along with higher-order functions (`where`, `firstWhere`, `any`, `toList()`). |
| **Exception Handling** | Custom hierarchy (`LibraryException`, `BookNotFoundException`, `BookAlreadyBorrowedException`, `BookNotBorrowedException`, `InvalidInputException`) with `try-on-catch` blocks. |
| **Null Safety** | Strict null-safe Dart patterns (`Book?`, `String?`, null-coalescing `??`). |

---

## 📋 Menu Structure

```text
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

---

## 🖥️ Sample Pre-Populated Data

Upon startup, the system is seeded with 5 classic books:
- `B001` - **The Great Gatsby** (*F. Scott Fitzgerald*, 1925) - Available
- `B002` - **1984** (*George Orwell*, 1949) - Available
- `B003` - **To Kill a Mockingbird** (*Harper Lee*, 1960) - Available
- `B004` - **Pride and Prejudice** (*Jane Austen*, 1813) - Available
- `B005` - **The Catcher in the Rye** (*J.D. Salinger*, 1951) - Available

---

## 📸 Sample Console Output

```text
============================================================
📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚
============================================================

📚 === ALL BOOKS ===
📚 ID: B001 | Title: The Great Gatsby | Author: F. Scott Fitzgerald | Year: 1925 | Status: ✅ Available
📚 ID: B002 | Title: 1984 | Author: George Orwell | Year: 1949 | Status: ✅ Available
📚 ID: B003 | Title: To Kill a Mockingbird | Author: Harper Lee | Year: 1960 | Status: ✅ Available
📚 ID: B004 | Title: Pride and Prejudice | Author: Jane Austen | Year: 1813 | Status: ✅ Available
📚 ID: B005 | Title: The Catcher in the Rye | Author: J.D. Salinger | Year: 1951 | Status: ✅ Available
📊 Total Books: 5
✅ Available: 5
❌ Borrowed: 0

============================================================
📊 === LIBRARY STATISTICS ===
============================================================
📚 Total Books in Catalog : 5
✅ Available Books        : 5
❌ Borrowed Books         : 0
📈 Availability Ratio     : 100.0%
============================================================
```
