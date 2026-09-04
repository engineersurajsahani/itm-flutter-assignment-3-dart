# Library Management System - Dart Console App

## How to Run
1. Install Dart SDK from https://dart.dev/get-dart
2. Save the file as `library_system.dart`
3. Run: `dart library_system.dart`
4. Or use DartPad: https://dartpad.dev/

## Features
- Add, view, borrow, return books
- Search by title
- View library statistics

## OOP Concepts Used
- **Classes & Objects**: `Book`, `Library`, and `LibraryApp` classes represent entities in the system.
- **Encapsulation**: Used private fields (e.g., `_id`, `_title`) in the `Book` class with appropriate getters and setters.
- **Inheritance**: The `Book` class extends the `LibraryItem` abstract class.
- **Abstraction**: `LibraryItem` is an abstract class defining the structure (`borrowItem()`, `returnItem()`, `displayInfo()`) for all library items without implementing them directly.
- **Polymorphism**: Demonstrated through method overriding. The `Library` class calls `displayInfo()` on any `LibraryItem`, and the specific `Book` implementation is executed at runtime.
- **Interface (Mixin)**: The `Printable` mixin is used to provide shared, reusable formatted printing functionality across classes.
