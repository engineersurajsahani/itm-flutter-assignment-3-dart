# Library Management System

A console-based Library Management System developed using Dart. This application allows users to manage books in a library by adding, viewing, borrowing, returning, and searching books.

## How to Run

1. Install the Dart SDK from Dart Documentation.
2. Save the source code as `library_system.dart`.
3. Open the terminal in the project folder.
4. Run the following command:

```bash
dart library_system.dart
```1

## Features

* View all books
* View available books
* View borrowed books
* Add a new book
* Borrow a book
* Return a book
* Search books by title
* View library statistics
* Error handling for invalid inputs

## OOP Concepts Used

This project demonstrates the following Object-Oriented Programming concepts:

* **Classes and Objects**
  Classes such as `Book`, `Library`, and `LibraryApp` are used to organize the application.

* **Encapsulation**
  The `Book` class uses private fields such as `_id`, `_title`, `_author`, `_year`, and `_isAvailable` with public getters and setters.

* **Inheritance**
  The `Book` class extends the abstract `LibraryItem` class.

* **Abstraction**
  The `LibraryItem` abstract class defines common methods such as `borrowItem()`, `returnItem()`, and `displayInfo()`.

* **Method Overriding**
  The methods from `LibraryItem` are overridden in the `Book` class.

* **Polymorphism**
  `LibraryItem` references are used to handle `Book` objects at runtime.

* **Constructors**
  A parameterized constructor is used to create `Book` objects.

* **Mixin**
  The `Searchable` mixin is used to provide book searching functionality.

## Sample Books

The application starts with the following sample books:

1. `B001` - Dracula's Midnight
2. `B002` - The Vampire's Promise
3. `B003` - Blood Moon
4. `B004` - Shadows of the Vampire
5. `B005` - The Last Immortal

## Menu Options

```text
1. View All Books
2. View Available Books
3. View Borrowed Books
4. Add a New Book
5. Borrow a Book
6. Return a Book
7. Search Books by Title
8. View Library Statistics
9. Exit
```

## Project Files

```text
Library-Management-System/
│
├── library_system.dart
├── README.md
└── screenshots/ (Optional)
```

## Author

Kinjal Gawali
