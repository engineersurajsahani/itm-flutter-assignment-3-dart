# 📚 Library Management System (Dart OOP) - Assignment 3

[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Paradigm](https://img.shields.io/badge/Paradigm-Object--Oriented-blueviolet?style=for-the-badge)](./)
[![Author](https://img.shields.io/badge/Author-Sayuj%20Pillai-blue?style=for-the-badge)](https://github.com/Sayuj63)

---

### 📌 Project Overview

An interactive, robust **Console-based Library Management System** developed in **Dart**, showcasing core **Object-Oriented Programming (OOP)** principles:
- **Abstraction**: Abstract base class `LibraryItem` defining common contract interfaces.
- **Encapsulation**: Private fields (`_id`, `_title`, `_author`, `_year`, `_isAvailable`) with public getters and setters.
- **Inheritance & Polymorphism**: `Book` class extending `LibraryItem` with overridden concrete implementations.
- **Collections & Lambda Operations**: Using Dart `List`, `.where()`, `.firstWhere()`, `.map()`, and higher-order collection methods.

---

### 👤 Student Details

- **Student Name:** Sayuj Pillai
- **Roll Number / ID:** 150096724107
- **GitHub Profile:** [@Sayuj63](https://github.com/Sayuj63)

---

## 🛠️ Features & System Architecture

### 1. Core Classes & Design
- **`abstract class LibraryItem`**: Defines contract methods `borrowItem()`, `returnItem()`, and `displayInfo()`.
- **`class Book extends LibraryItem`**: Encapsulates book state with availability status and formatting.
- **`class Library`**: Manages book repository, automatic ID generation (`B001`, `B002`, ...), searching, borrowing, returning, and statistics.
- **`class LibraryApp`**: Interactive command-line menu interface with robust user input handling.

---

## 📋 Menu Options

```
============================================================
WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 
============================================================

------------------------------------------------------------
 MAIN MENU
------------------------------------------------------------
1.  View All Books
2.  View Available Books
3.  View Borrowed Books
4.  Add a New Book
5.  Borrow a Book
6.  Return a Book
7.  Search Books by Title
8.  View Library Statistics
9.  Exit
------------------------------------------------------------
```

---

## 🚀 Getting Started & Execution

### Prerequisites
Ensure the Dart SDK (version 3.0+) is installed:
```bash
dart --version
```

### Running the Application
```bash
# Clone the repository
git clone https://github.com/Sayuj63/150096724107_Sayuj_Pillai_Assignment-3.git
cd 150096724107_Sayuj_Pillai_Assignment-3

# Run the library system
dart library_system.dart
```

---

<p align="center">
  <b>Created with ❤️ by Sayuj Pillai (150096724107)</b>
</p>
