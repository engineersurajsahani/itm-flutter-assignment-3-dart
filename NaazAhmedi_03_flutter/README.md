# Library Management System

A console-based Library Management System developed in Dart using Object-Oriented Programming (OOP) concepts for ITM Flutter Assignment 3.

## Student Details
- **Name**: Naaz Ahmedi
- **Assignment**: Assignment 3 - Dart OOP

---

## Features
1. **View All Books**: List all books in the library with their details and current availability status.
2. **Add New Book**: Add a book with unique ID, title, author, and publication year.
3. **Borrow Book**: Mark an available book as borrowed.
4. **Return Book**: Return a borrowed book and mark it as available.
5. **Search Books**: Search books by title or author name.
6. **Library Statistics**: View total books count, available books count, and borrowed books count.
7. **Error Handling**: Handles invalid inputs, duplicate IDs, and invalid operations gracefully.

---

## OOP Concepts Used
- **Abstraction**: Abstract `LibraryItem` class defining the core contract.
- **Inheritance & Polymorphism**: `Book` class implementing `LibraryItem`.
- **Encapsulation**: Private fields with getters, setters, and validation.
- **Exception & Error Handling**: Validating user inputs and library operations.

---

## How to Run
Run the Dart file using the Dart SDK:
```bash
dart library_system.dart
```

---

## Output Screenshots
1. **Main Menu**: `1_MainMenu.png`
2. **Borrow Book**: `2_Borrow_BorrowedBook.png`
3. **Return Book**: `3_BookReturnSuccessfully.png`
4. **Add Book**: `4_BookAddedSuccessfully.png`
5. **Search Books**: `5_SearchBooks.png`
6. **Statistics**: `6_Statistics.png`
7. **Error Handling**: `7_ErrorHandling.png`
