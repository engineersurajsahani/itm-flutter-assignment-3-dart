import 'dart:io';


// ================================
// ABSTRACT CLASS
// Demonstrates Abstraction
// ================================
abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}


// ================================
// MIXIN
// Used for searching functionality
// ================================
mixin Searchable {
  bool matchesSearch(String title, String keyword) {
    return title.toLowerCase().contains(keyword.toLowerCase());
  }
}


// ================================
// BOOK CLASS
// Demonstrates:
// Encapsulation
// Constructor
// Inheritance
// Method Overriding
// ================================
class Book extends LibraryItem {
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  // Parameterized constructor
  Book(
    this._id,
    this._title,
    this._author,
    this._year,
    this._isAvailable,
  );

  // Getters
  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  // Setters
  set title(String value) {
    if (value.isNotEmpty) {
      _title = value;
    }
  }

  set author(String value) {
    if (value.isNotEmpty) {
      _author = value;
    }
  }

  set year(int value) {
    if (value > 0) {
      _year = value;
    }
  }


  // Method overriding
  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('\nBook borrowed successfully: $_title');
    } else {
      print('\nThis book is already borrowed.');
    }
  }


  // Method overriding
  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('\nBook returned successfully: $_title');
    } else {
      print('\nThis book was not borrowed.');
    }
  }


  // Method overriding
  @override
  void displayInfo() {
    String status = _isAvailable ? 'Available' : 'Borrowed';

    print(
      'ID: $_id | '
      'Title: $_title | '
      'Author: $_author | '
      'Year: $_year | '
      'Status: $status',
    );
  }
}


// ================================
// LIBRARY CLASS
// Manages List<Book>
// ================================
class Library with Searchable {
  List<Book> books = [];


  void addBook(String title, String author, int year) {
    if (title.isEmpty || author.isEmpty || year <= 0) {
      print('\nInvalid book details.');
      return;
    }

    String idNumber = (books.length + 1).toString().padLeft(3, '0');
    String id = 'B$idNumber';

    Book newBook = Book(
      id,
      title,
      author,
      year,
      true,
    );

    books.add(newBook);

    print('\nBook added successfully.');
    print('Book ID: $id');
  }


  void viewAllBooks() {
    if (books.isEmpty) {
      print('\nNo books found.');
      return;
    }

    print('\n===== ALL BOOKS =====');

    // Runtime Polymorphism
    // Book objects are treated as LibraryItem objects
    for (LibraryItem item in books) {
      item.displayInfo();
    }
  }


  void viewAvailableBooks() {
    bool found = false;

    print('\n===== AVAILABLE BOOKS =====');

    for (Book book in books) {
      if (book.isAvailable) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No books are currently available.');
    }
  }


  void viewBorrowedBooks() {
    bool found = false;

    print('\n===== BORROWED BOOKS =====');

    for (Book book in books) {
      if (!book.isAvailable) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No books are currently borrowed.');
    }
  }


  void borrowBook(String id) {
    Book? foundBook;

    for (Book book in books) {
      if (book.id.toLowerCase() == id.toLowerCase()) {
        foundBook = book;
        break;
      }
    }

    if (foundBook == null) {
      print('\nBook ID not found.');
    } else {
      foundBook.borrowItem();
    }
  }


  void returnBook(String id) {
    Book? foundBook;

    for (Book book in books) {
      if (book.id.toLowerCase() == id.toLowerCase()) {
        foundBook = book;
        break;
      }
    }

    if (foundBook == null) {
      print('\nBook ID not found.');
    } else {
      foundBook.returnItem();
    }
  }


  void searchBooks(String keyword) {
    if (keyword.isEmpty) {
      print('\nPlease enter a title to search.');
      return;
    }

    bool found = false;

    print('\n===== SEARCH RESULTS =====');

    for (Book book in books) {
      if (matchesSearch(book.title, keyword)) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No book found with this title.');
    }
  }


  void displayStatistics() {
    int totalBooks = books.length;
    int availableBooks = 0;
    int borrowedBooks = 0;

    for (Book book in books) {
      if (book.isAvailable) {
        availableBooks++;
      } else {
        borrowedBooks++;
      }
    }

    double availabilityPercentage = 0;

    if (totalBooks > 0) {
      availabilityPercentage =
          (availableBooks / totalBooks) * 100;
    }

    print('\n===== LIBRARY STATISTICS =====');
    print('Total Books: $totalBooks');
    print('Available Books: $availableBooks');
    print('Borrowed Books: $borrowedBooks');
    print(
      'Availability Percentage: '
      '${availabilityPercentage.toStringAsFixed(2)}%',
    );
  }
}


// ================================
// LIBRARY APP CLASS
// Controls menu and user interaction
// ================================
class LibraryApp {
  final Library library = Library();


  // Sample Data
  void addSampleBooks() {
    library.books.add(
      Book(
        'B001',
        'Draculas Midnight',
        'Bram Stoker',
        1897,
        true,
      ),
    );

    library.books.add(
      Book(
        'B002',
        'The Vampires Promise',
        'Elena Blackwood',
        2015,
        true,
      ),
    );

    library.books.add(
      Book(
        'B003',
        'Blood Moon',
        'Sarah Night',
        2020,
        true,
      ),
    );

    library.books.add(
      Book(
        'B004',
        'Shadows of the Vampire',
        'Daniel Crow',
        2018,
        true,
      ),
    );

    library.books.add(
      Book(
        'B005',
        'The Last Immortal',
        'Victoria Dark',
        2022,
        true,
      ),
    );
  }


  void displayMenu() {
    print('\n======================================');
    print('       LIBRARY MANAGEMENT SYSTEM');
    print('======================================');

    print('1. View All Books');
    print('2. View Available Books');
    print('3. View Borrowed Books');
    print('4. Add a New Book');
    print('5. Borrow a Book');
    print('6. Return a Book');
    print('7. Search Books by Title');
    print('8. View Library Statistics');
    print('9. Exit');
  }


  void start() {
    addSampleBooks();

    print('Welcome to the Library Management System!');

    bool isRunning = true;

    while (isRunning) {
      displayMenu();

      stdout.write('\nEnter your choice (1-9): ');
      String? input = stdin.readLineSync();

      int? choice = int.tryParse(input ?? '');

      switch (choice) {
        case 1:
          library.viewAllBooks();
          break;

        case 2:
          library.viewAvailableBooks();
          break;

        case 3:
          library.viewBorrowedBooks();
          break;

        case 4:
          addNewBook();
          break;

        case 5:
          borrowBook();
          break;

        case 6:
          returnBook();
          break;

        case 7:
          searchBook();
          break;

        case 8:
          library.displayStatistics();
          break;

        case 9:
          print('\nThank you for using the Library Management System!');
          isRunning = false;
          break;

        default:
          print('\nInvalid choice. Please enter a number from 1 to 9.');
      }
    }
  }


  void addNewBook() {
    stdout.write('\nEnter book title: ');
    String title = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Enter author name: ');
    String author = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Enter publication year: ');
    String yearInput = stdin.readLineSync()?.trim() ?? '';

    int? year = int.tryParse(yearInput);

    if (year == null) {
      print('\nInvalid year.');
      return;
    }

    library.addBook(title, author, year);
  }


  void borrowBook() {
    stdout.write('\nEnter Book ID to borrow: ');
    String id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('\nBook ID cannot be empty.');
      return;
    }

    library.borrowBook(id);
  }


  void returnBook() {
    stdout.write('\nEnter Book ID to return: ');
    String id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('\nBook ID cannot be empty.');
      return;
    }

    library.returnBook(id);
  }


  void searchBook() {
    stdout.write('\nEnter book title to search: ');
    String keyword = stdin.readLineSync()?.trim() ?? '';

    library.searchBooks(keyword);
  }
}


// ================================
// MAIN FUNCTION
// ================================
void main() {
  LibraryApp app = LibraryApp();
  app.start();
}