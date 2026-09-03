// A - Core Features

// 1. Add Books: Users should be able to add a new book to the library by providing title, author, and year.
// 2. View Books: Display all books, available books, and borrowed books separately.
// 3. Borrow Books: Users can borrow a book by entering its unique ID. A book can only be borrowed if it's available.
// 4. Return Books: Users can return a borrowed book by entering its ID.
// 5. Search Books: Search for books by title (partial matches allowed).
// 6. Library Statistics: Display total books, available, borrowed, and availability percentage.



// B -  Technical Requirements

// 1. Book Class: Must have private fields (_id, _title, _author, _year, _isAvailable) with appropriate getters and setters (Encapsulation).
// 2. LibraryItem Abstract Class: Create an abstract class with methods borrowItem(), returnItem(), displayInfo() (Abstraction).
// 3. Inheritance: Book class must extend LibraryItem and override all abstract methods.
// 4. Library Class: Manages a List<Book> with methods to add, search, borrow, return, and display books.
// 5. LibraryApp Class: Controls the main menu and user interaction loop.
// 6. Main Function: Entry point that instantiates LibraryApp and starts the application.
// 7. Error Handling: Handle invalid inputs (e.g., non-existent book ID, empty fields).
// 8. Sample Data: Pre-populate the library with at least 5 sample books.


import 'dart:io';

import 'book.dart';
import 'library.dart';

class LibraryApp {
  final Library _library = Library();

  // Start the application
  void start() {
    _addSampleBooks();

    print('===================================');
    print('     LIBRARY MANAGEMENT SYSTEM      ');
    print('===================================');

    bool running = true;

    while (running) {
      _showMenu();

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          _addBook();
          break;

        case '2':
          _library.displayAllBooks();
          break;

        case '3':
          _library.displayAvailableBooks();
          break;

        case '4':
          _library.displayBorrowedBooks();
          break;

        case '5':
          _borrowBook();
          break;

        case '6':
          _returnBook();
          break;

        case '7':
          _searchBooks();
          break;

        case '8':
          _library.displayStatistics();
          break;

        case '9':
          print('\nThank you for using the Library Management System.');
          running = false;
          break;

        default:
          print('Invalid choice. Please enter a number from 1 to 9.');
      }

      if (running) {
        print('\nPress Enter to continue...');
        stdin.readLineSync();
      }
    }
  }

  // Display main menu
  void _showMenu() {
    print('\n');
    print('=========== MENU ===========');
    print('1. Add Book');
    print('2. View All Books');
    print('3. View Available Books');
    print('4. View Borrowed Books');
    print('5. Borrow Book');
    print('6. Return Book');
    print('7. Search Books');
    print('8. Library Statistics');
    print('9. Exit');
    print('============================');
    stdout.write('Enter your choice: ');
  }

  // Add a new book through user input
  void _addBook() {
    print('\n--- Add Book ---');

    stdout.write('Enter book ID: ');
    String? idInput = stdin.readLineSync();

    int? id = int.tryParse(idInput ?? '');

    if (id == null || id <= 0) {
      print('Invalid book ID.');
      return;
    }

    stdout.write('Enter title: ');
    String title = (stdin.readLineSync() ?? '').trim();

    if (title.isEmpty) {
      print('Title cannot be empty.');
      return;
    }

    stdout.write('Enter author: ');
    String author = (stdin.readLineSync() ?? '').trim();

    if (author.isEmpty) {
      print('Author cannot be empty.');
      return;
    }

    stdout.write('Enter publication year: ');
    String? yearInput = stdin.readLineSync();

    int? year = int.tryParse(yearInput ?? '');

    if (year == null || year <= 0) {
      print('Invalid publication year.');
      return;
    }

    Book book = Book(
      id,
      title,
      author,
      year,
    );

    _library.addBook(book);
  }

  // Borrow a book
  void _borrowBook() {
    print('\n--- Borrow Book ---');

    stdout.write('Enter book ID: ');
    String? input = stdin.readLineSync();

    int? id = int.tryParse(input ?? '');

    if (id == null || id <= 0) {
      print('Invalid book ID.');
      return;
    }

    _library.borrowBook(id);
  }

  // Return a book
  void _returnBook() {
    print('\n--- Return Book ---');

    stdout.write('Enter book ID: ');
    String? input = stdin.readLineSync();

    int? id = int.tryParse(input ?? '');

    if (id == null || id <= 0) {
      print('Invalid book ID.');
      return;
    }

    _library.returnBook(id);
  }

  // Search books
  void _searchBooks() {
    print('\n--- Search Books ---');

    stdout.write('Enter title to search: ');
    String query = (stdin.readLineSync() ?? '').trim();

    if (query.isEmpty) {
      print('Search query cannot be empty.');
      return;
    }

    _library.searchBooks(query);
  }

  // Pre-populate library with sample data
  void _addSampleBooks() {
    _library.addBook(
      Book(101, 'The Alchemist', 'Paulo Coelho', 1988),
    );

    _library.addBook(
      Book(102, 'Atomic Habits', 'James Clear', 2018),
    );

    _library.addBook(
      Book(103, 'Clean Code', 'Robert C. Martin', 2008),
    );

    _library.addBook(
      Book(104, 'The Hobbit', 'J.R.R. Tolkien', 1937),
    );

    _library.addBook(
      Book(105, 'Harry Potter', 'J.K. Rowling', 1997),
    );
  }
}

void main() {
  LibraryApp app = LibraryApp();
  app.start();
}