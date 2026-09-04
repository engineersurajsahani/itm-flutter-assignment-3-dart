import 'dart:io';

// ======================================================
// ABSTRACT CLASS - ABSTRACTION
// ======================================================

abstract class LibraryItem {
  void borrowItem();

  void returnItem();

  void displayInfo();
}

// ======================================================
// BOOK CLASS
// INHERITANCE + ENCAPSULATION + POLYMORPHISM
// ======================================================

class Book extends LibraryItem {
  // Private fields
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  // Constructor
  Book(
    this._id,
    this._title,
    this._author,
    this._year, [
    this._isAvailable = true,
  ]);

  // =========================
  // GETTERS
  // =========================

  String get id => _id;

  String get title => _title;

  String get author => _author;

  int get year => _year;

  bool get isAvailable => _isAvailable;

  // =========================
  // SETTERS
  // =========================

  set title(String value) {
    if (value.trim().isNotEmpty) {
      _title = value;
    }
  }

  set author(String value) {
    if (value.trim().isNotEmpty) {
      _author = value;
    }
  }

  set year(int value) {
    if (value > 0 && value <= DateTime.now().year) {
      _year = value;
    }
  }

  // =========================
  // OVERRIDDEN METHODS
  // =========================

  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('"$_title" has been borrowed successfully.');
    } else {
      print('"$_title" is already borrowed.');
    }
  }

  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('"$_title" has been returned successfully.');
    } else {
      print('"$_title" is already available in the library.');
    }
  }

  @override
  void displayInfo() {
    String status = _isAvailable ? 'Available' : 'Borrowed';

    print('''
----------------------------------------
Book ID : $_id
Title   : $_title
Author  : $_author
Year    : $_year
Status  : $status
----------------------------------------
''');
  }
}

// ======================================================
// LIBRARY CLASS
// MANAGES ALL BOOKS
// ======================================================

class Library {
  // Collection of books
  List<Book> books = [];

  // Add a book
  void addBook(Book book) {
    // Check if ID already exists
    bool exists = books.any((b) => b.id == book.id);

    if (exists) {
      print('\nBook with ID ${book.id} already exists.');
      return;
    }

    books.add(book);

    print('\nBook added successfully!');
  }

  // ==================================================
  // VIEW ALL BOOKS
  // ==================================================

  void viewAllBooks() {
    if (books.isEmpty) {
      print('\nNo books available in the library.');
      return;
    }

    print('\n========== ALL BOOKS ==========');

    for (Book book in books) {
      book.displayInfo();
    }
  }

  // ==================================================
  // VIEW AVAILABLE BOOKS
  // ==================================================

  void viewAvailableBooks() {
    List<Book> availableBooks =
        books.where((book) => book.isAvailable).toList();

    if (availableBooks.isEmpty) {
      print('\nNo books are currently available.');
      return;
    }

    print('\n========== AVAILABLE BOOKS ==========');

    for (Book book in availableBooks) {
      book.displayInfo();
    }
  }

  // ==================================================
  // VIEW BORROWED BOOKS
  // ==================================================

  void viewBorrowedBooks() {
    List<Book> borrowedBooks =
        books.where((book) => !book.isAvailable).toList();

    if (borrowedBooks.isEmpty) {
      print('\nNo books are currently borrowed.');
      return;
    }

    print('\n========== BORROWED BOOKS ==========');

    for (Book book in borrowedBooks) {
      book.displayInfo();
    }
  }

  // ==================================================
  // FIND BOOK BY ID
  // ==================================================

  Book? findBookById(String id) {
    for (Book book in books) {
      if (book.id.toLowerCase() == id.toLowerCase()) {
        return book;
      }
    }

    return null;
  }

  // ==================================================
  // BORROW BOOK
  // ==================================================

  void borrowBook(String id) {
    Book? book = findBookById(id);

    if (book == null) {
      print('\nBook with ID "$id" was not found.');
      return;
    }

    book.borrowItem();
  }

  // ==================================================
  // RETURN BOOK
  // ==================================================

  void returnBook(String id) {
    Book? book = findBookById(id);

    if (book == null) {
      print('\nBook with ID "$id" was not found.');
      return;
    }

    book.returnItem();
  }

  // ==================================================
  // SEARCH BOOK BY TITLE
  // ==================================================

  void searchBook(String searchTitle) {
    List<Book> results = books
        .where(
          (book) =>
              book.title.toLowerCase().contains(searchTitle.toLowerCase()),
        )
        .toList();

    if (results.isEmpty) {
      print('\nNo books found with title "$searchTitle".');
      return;
    }

    print('\n========== SEARCH RESULTS ==========');

    for (Book book in results) {
      book.displayInfo();
    }
  }

  // ==================================================
  // LIBRARY STATISTICS
  // ==================================================

  void showStatistics() {
    int totalBooks = books.length;

    int availableBooks =
        books.where((book) => book.isAvailable).length;

    int borrowedBooks =
        books.where((book) => !book.isAvailable).length;

    print('''
========== LIBRARY STATISTICS ==========

Total Books     : $totalBooks
Available Books : $availableBooks
Borrowed Books  : $borrowedBooks

========================================
''');
  }
}

// ======================================================
// LIBRARY APP CLASS
// HANDLES MENU AND USER INTERACTION
// ======================================================

class LibraryApp {
  final Library library = Library();

  // ==================================================
  // ADD SAMPLE BOOKS
  // ==================================================

  void addSampleBooks() {
    library.addBook(
      Book(
        'B001',
        'The Great Gatsby',
        'F. Scott Fitzgerald',
        1925,
      ),
    );

    library.addBook(
      Book(
        'B002',
        '1984',
        'George Orwell',
        1949,
      ),
    );

    library.addBook(
      Book(
        'B003',
        'To Kill a Mockingbird',
        'Harper Lee',
        1960,
      ),
    );

    library.addBook(
      Book(
        'B004',
        'Harry Potter and the Sorcerer\'s Stone',
        'J.K. Rowling',
        1997,
      ),
    );

    library.addBook(
      Book(
        'B005',
        'The Alchemist',
        'Paulo Coelho',
        1988,
      ),
    );
  }

  // ==================================================
  // DISPLAY MENU
  // ==================================================

  void displayMenu() {
    print('''
    
========== LIBRARY MANAGEMENT SYSTEM ==========

1. View All Books
2. View Available Books
3. View Borrowed Books
4. Add a New Book
5. Borrow a Book
6. Return a Book
7. Search Books by Title
8. View Library Statistics
9. Exit

================================================
''');
  }

  // ==================================================
  // ADD NEW BOOK
  // ==================================================

  void addNewBook() {
    print('\n========== ADD NEW BOOK ==========');

    stdout.write('Enter Book ID: ');
    String id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('Book ID cannot be empty.');
      return;
    }

    stdout.write('Enter Book Title: ');
    String title = stdin.readLineSync()?.trim() ?? '';

    if (title.isEmpty) {
      print('Book title cannot be empty.');
      return;
    }

    stdout.write('Enter Author Name: ');
    String author = stdin.readLineSync()?.trim() ?? '';

    if (author.isEmpty) {
      print('Author name cannot be empty.');
      return;
    }

    stdout.write('Enter Publication Year: ');
    int? year = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (year == null ||
        year <= 0 ||
        year > DateTime.now().year) {
      print('Please enter a valid year.');
      return;
    }

    Book newBook = Book(
      id,
      title,
      author,
      year,
    );

    library.addBook(newBook);
  }

  // ==================================================
  // RUN APPLICATION
  // ==================================================

  void run() {
    // Add 5 sample books
    addSampleBooks();

    print('\nWelcome to the Library Management System!');

    bool isRunning = true;

    while (isRunning) {
      displayMenu();

      stdout.write('Enter your choice: ');

      String input = stdin.readLineSync()?.trim() ?? '';

      int? choice = int.tryParse(input);

      if (choice == null) {
        print('\nInvalid input! Please enter a number from 1 to 9.');
        continue;
      }

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
          stdout.write('\nEnter Book ID to borrow: ');
          String id = stdin.readLineSync()?.trim() ?? '';

          if (id.isEmpty) {
            print('Book ID cannot be empty.');
          } else {
            library.borrowBook(id);
          }

          break;

        case 6:
          stdout.write('\nEnter Book ID to return: ');
          String id = stdin.readLineSync()?.trim() ?? '';

          if (id.isEmpty) {
            print('Book ID cannot be empty.');
          } else {
            library.returnBook(id);
          }

          break;

        case 7:
          stdout.write('\nEnter book title to search: ');
          String title = stdin.readLineSync()?.trim() ?? '';

          if (title.isEmpty) {
            print('Search title cannot be empty.');
          } else {
            library.searchBook(title);
          }

          break;

        case 8:
          library.showStatistics();
          break;

        case 9:
          print('\nThank you for using the Library Management System!');
          print('Goodbye!');
          isRunning = false;
          break;

        default:
          print('\nInvalid choice! Please select a number from 1 to 9.');
      }
    }
  }
}

// ======================================================
// MAIN FUNCTION
// ======================================================

void main() {
  LibraryApp app = LibraryApp();

  app.run();
}