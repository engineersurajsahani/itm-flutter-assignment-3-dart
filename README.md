# Library Management System — Dart Console App

A menu-driven console application for managing a small library. It includes five pre-loaded books and supports adding, viewing, borrowing, returning, searching, and statistics.

## Requirements

- [Dart SDK](https://dart.dev/get-dart) 3.0 or later

## Run

From this directory, run:

```bash
dart library_system.dart
```

Alternatively, paste `library_system.dart` into [DartPad](https://dartpad.dev/) and run it there.

## Features

- View all, available, or borrowed books
- Add books with generated IDs (`B001`, `B002`, …)
- Borrow and return books by ID
- Case-insensitive partial title search
- Library availability statistics
- Validation for menu choices, blank fields, invalid years, missing IDs, and invalid borrow/return actions

## OOP concepts demonstrated

- **Classes and objects:** `Book`, `Library`, and `LibraryApp`
- **Encapsulation:** private fields with public getters and validated setters
- **Abstraction and inheritance:** `Book` extends the abstract `LibraryItem`
- **Method overriding and runtime polymorphism:** overridden `borrowItem`, `returnItem`, and `displayInfo` methods are called through `LibraryItem`
- **Mixin:** `Identifiable` supplies the ID contract
- **Constructors:** named parameters and an optional `isAvailable` parameter
