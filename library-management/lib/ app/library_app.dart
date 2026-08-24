import 'dart:io';

import '../book.dart';
import '../services/library.dart';

class LibraryApp {
  final Library library;

  LibraryApp(this.library);

  // Starts the application
  void start() {
    while (true) {
      displayMenu();

      String? choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          addBook();
          break;

        case '2':
          library.displayAllBooks();
          break;

        case '3':
          library.displayAvailableBooks();
          break;

        case '4':
          library.displayBorrowedBooks();
          break;

        case '5':
          searchBook();
          break;

        case '6':
          borrowBook();
          break;

        case '7':
          returnBook();
          break;

        case '8':
          library.showStatistics();
          break;

        case '9':
          print('\nThank you for using the Library Management System!');
          return;

        default:
          print('\nInvalid choice. Please enter a number from 1 to 9.');
      }

      print('\nPress Enter to continue...');
      stdin.readLineSync();
    }
  }

  // Displays the main menu
  void displayMenu() {
    print('\n');
    print('======================================');
    print('      LIBRARY MANAGEMENT SYSTEM');
    print('======================================');
    print('1. Add Book');
    print('2. View All Books');
    print('3. View Available Books');
    print('4. View Borrowed Books');
    print('5. Search Book');
    print('6. Borrow Book');
    print('7. Return Book');
    print('8. Show Statistics');
    print('9. Exit');
    print('======================================');
    stdout.write('Enter your choice: ');
  }

  // Add a new book
  void addBook() {
    print('\n===== ADD NEW BOOK =====');

    stdout.write('Enter Book ID: ');
    String? idInput = stdin.readLineSync();

    int? id = int.tryParse(idInput ?? '');

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    stdout.write('Enter Book Title: ');
    String title = stdin.readLineSync() ?? '';

    if (title.trim().isEmpty) {
      print('Title cannot be empty.');
      return;
    }

    stdout.write('Enter Author: ');
    String author = stdin.readLineSync() ?? '';

    if (author.trim().isEmpty) {
      print('Author cannot be empty.');
      return;
    }

    stdout.write('Enter Publication Year: ');
    String? yearInput = stdin.readLineSync();

    int? year = int.tryParse(yearInput ?? '');

    if (year == null) {
      print('Invalid year. Please enter a number.');
      return;
    }

    Book book = Book(
      id: id,
      title: title,
      author: author,
      year: year,
    );

    library.addBook(book);
  }

  // Search for a book
  void searchBook() {
    print('\n===== SEARCH BOOK =====');

    stdout.write('Enter book title to search: ');
    String query = stdin.readLineSync() ?? '';

    if (query.trim().isEmpty) {
      print('Search query cannot be empty.');
      return;
    }

    library.searchBook(query);
  }

  // Borrow a book
  void borrowBook() {
    print('\n===== BORROW BOOK =====');

    stdout.write('Enter Book ID: ');
    String? input = stdin.readLineSync();

    int? id = int.tryParse(input ?? '');

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    library.borrowBook(id);
  }

  // Return a book
  void returnBook() {
    print('\n===== RETURN BOOK =====');

    stdout.write('Enter Book ID: ');
    String? input = stdin.readLineSync();

    int? id = int.tryParse(input ?? '');

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    library.returnBook(id);
  }
}