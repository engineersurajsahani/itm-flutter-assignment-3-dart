Library Management System

A console-based Library Management System developed in Dart using
Object-Oriented Programming (OOP) concepts.

Project Overview

This project allows users to manage books in a library through a simple
command-line menu. Users can view books, add new books, borrow and
return books, search for books, and view library statistics.

The project demonstrates important Dart and OOP concepts such as
abstraction, inheritance, encapsulation, polymorphism, constructors,
collections, loops, conditional statements, and error handling.

Features

View all books

View available books

View borrowed books

Add a new book

Borrow a book using its ID

Return a book using its ID

Search books by title

View library statistics

Prevent duplicate book IDs

Handle invalid user input

Start with five sample books

Case-insensitive book title search

OOP Concepts Used

1. Abstraction

The LibraryItem class is declared as an abstract class.

abstract class LibraryItem {
  int get id;
  String get title;
  String get author;
  int get year;

  void displayInfo();
}

It defines the common properties and behavior that a library item should
have.

2. Inheritance

The Book class inherits from LibraryItem.

class Book extends LibraryItem

This allows Book to use and implement the members defined by the
abstract parent class.

3. Encapsulation

The Book class stores its data using private fields:

int _id;
String _title;
String _author;
int _year;
bool _isAvailable;

Getters and setters are used to access and modify these fields.

4. Method Overriding

The Book class overrides members of LibraryItem, including
displayInfo() and the required getters.

@override
void displayInfo() {
  // Displays book information
}

5. Polymorphism

The program uses the common LibraryItem interface while allowing the
Book class to provide its own implementation of the required behavior.

6. Constructors

Constructors are used to initialize objects such as Book, Library,
and LibraryApp.

7. Collections

The Library class stores books using a Dart list:

final List<Book> _books = [];

Class Structure

LibraryItem (Abstract Class)
          |
          v
        Book
          |
          v
       Library
          |
          v
      LibraryApp
          |
          v
         main()

Application Menu

========== LIBRARY MANAGEMENT SYSTEM ==========
1. View All Books
2. View Available Books
3. View Borrowed Books
4. Add New Book
5. Borrow Book
6. Return Book
7. Search Book by Title
8. Library Statistics
9. Exit
================================================

Sample Books

The application starts with five sample books:

ID   Title              Author                  Year

1    The Alchemist      Paulo Coelho            1988
2    Atomic Habits      James Clear             2018
3    Harry Potter       J.K. Rowling            1997
4    The Great Gatsby   F. Scott Fitzgerald     1925
5    Clean Code         Robert C. Martin        2008

All sample books are initially available.

How to Run

Prerequisites

Make sure Dart SDK is installed on your system.

Check the Dart installation with:

dart --version

Run the Project

Open the terminal in the project directory and run:

dart run library_system.dart

The Library Management System menu will appear in the terminal.

Example Operations

Borrowing a Book

Enter your choice: 5

===== BORROW BOOK =====
Enter Book ID: 1
Book borrowed successfully.

Returning a Book

Enter your choice: 6

===== RETURN BOOK =====
Enter Book ID: 1
Book returned successfully.

Searching for a Book

Enter your choice: 7

===== SEARCH BOOK =====
Enter title to search: atomic

===== SEARCH RESULTS =====
ID: 2 | Title: Atomic Habits | Author: James Clear | Year: 2018 | Status: Available

Library Statistics

===== LIBRARY STATISTICS =====
Total Books     : 5
Available Books : 5
Borrowed Books  : 0

Error Handling

The application handles common invalid inputs, including:

Non-numeric menu choices

Invalid book IDs

Duplicate book IDs

Invalid publication years

Searching with an empty title

Attempting to borrow an already borrowed book

Attempting to return an already available book

Searching for a book that does not exist

Technologies Used

Dart

Object-Oriented Programming

Dart dart:io library

Command-line interface

Project Files

Assignment_3/
│
├── library_system.dart
└── README.md

Learning Outcomes

Through this project, the following concepts were practiced:

Designing classes and objects

Implementing abstraction and inheritance

Applying encapsulation using private fields

Using getters and setters

Overriding methods

Working with Dart collections

Handling user input

Implementing menu-driven programs

Applying validation and error handling

Building a complete console-based application

Author

Sneha Hande

B.Tech Computer Science Engineering
ITM Skills University
2024--2028