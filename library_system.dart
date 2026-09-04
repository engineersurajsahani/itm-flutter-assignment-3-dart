import 'dart:io';

// ======================================================
// ABSTRACT CLASS - ABSTRACTION
// ======================================================

/// Abstract class representing an item in the library
abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}

// ======================================================
// BOOK CLASS
// INHERITANCE + ENCAPSULATION + POLYMORPHISM
// ======================================================

/// Book class inheriting from LibraryItem
class Book extends LibraryItem {
  // Private fields (Encapsulation)
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  // Constructor with optional parameter for availability
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
      _title = value.trim();
    }
  }

  set author(String value) {
    if (value.trim().isNotEmpty) {
      _author = value.trim();
    }
  }

  set year(int value) {
    if (value > 0 && value <= DateTime.now().year) {
      _year = value;
    }
  }

  // =========================
  // OVERRIDDEN METHODS (Polymorphism)
  // =========================

  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('✅ Success: "$_title" (ID: $_id) has been borrowed successfully.');
    } else {
      print('⚠️  Notice: "$_title" (ID: $_id) is already borrowed.');
    }
  }

  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('✅ Success: "$_title" (ID: $_id) has been returned successfully.');
    } else {
      print('ℹ️  Notice: "$_title" (ID: $_id) is already available in the library.');
    }
  }

  @override
  void displayInfo() {
    String status = _isAvailable ? '✅ Available' : '❌ Borrowed';
    print('📚 ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $status');
  }
}

// ======================================================
// LIBRARY CLASS
// MANAGES ALL BOOKS & INVENTORY
// ======================================================

class Library {
  // Collection of books
  final List<Book> _books = [];

  // Getter for books list
  List<Book> get books => List.unmodifiable(_books);

  // Add a book
  bool addBook(Book book) {
    // Check if ID already exists (case-insensitive)
    bool exists = _books.any(
      (b) => b.id.trim().toLowerCase() == book.id.trim().toLowerCase(),
    );

    if (exists) {
      print('❌ Error: Book with ID "${book.id}" already exists.');
      return false;
    }

    _books.add(book);
    print('✅ Success: Book "${book.title}" added successfully with ID ${book.id}!');
    return true;
  }

  // ==================================================
  // VIEW ALL BOOKS
  // ==================================================

  void viewAllBooks() {
    if (_books.isEmpty) {
      print('\nℹ️  No books available in the library.');
      return;
    }

    print('\n📚 === ALL BOOKS ===');
    for (Book book in _books) {
      book.displayInfo();
    }

    int availableCount = _books.where((b) => b.isAvailable).length;
    int borrowedCount = _books.where((b) => !b.isAvailable).length;
    print('------------------------------------------------------------');
    print('📊 Total Books: ${_books.length} | ✅ Available: $availableCount | ❌ Borrowed: $borrowedCount');
  }

  // ==================================================
  // VIEW AVAILABLE BOOKS
  // ==================================================

  void viewAvailableBooks() {
    List<Book> availableBooks = _books.where((book) => book.isAvailable).toList();

    if (availableBooks.isEmpty) {
      print('\nℹ️  No books are currently available.');
      return;
    }

    print('\n✅ === AVAILABLE BOOKS ===');
    for (Book book in availableBooks) {
      book.displayInfo();
    }
    print('------------------------------------------------------------');
    print('Total Available Books: ${availableBooks.length}');
  }

  // ==================================================
  // VIEW BORROWED BOOKS
  // ==================================================

  void viewBorrowedBooks() {
    List<Book> borrowedBooks = _books.where((book) => !book.isAvailable).toList();

    if (borrowedBooks.isEmpty) {
      print('\nℹ️  No books are currently borrowed.');
      return;
    }

    print('\n❌ === BORROWED BOOKS ===');
    for (Book book in borrowedBooks) {
      book.displayInfo();
    }
    print('------------------------------------------------------------');
    print('Total Borrowed Books: ${borrowedBooks.length}');
  }

  // ==================================================
  // FIND BOOK BY ID
  // ==================================================

  Book? findBookById(String id) {
    for (Book book in _books) {
      if (book.id.trim().toLowerCase() == id.trim().toLowerCase()) {
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
      print('\n❌ Error: Book with ID "$id" was not found.');
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
      print('\n❌ Error: Book with ID "$id" was not found.');
      return;
    }

    book.returnItem();
  }

  // ==================================================
  // SEARCH BOOK BY TITLE
  // ==================================================

  void searchBook(String searchTitle) {
    List<Book> results = _books
        .where(
          (book) => book.title.toLowerCase().contains(searchTitle.trim().toLowerCase()),
        )
        .toList();

    if (results.isEmpty) {
      print('\n🔍 No books found matching title "$searchTitle".');
      return;
    }

    print('\n🔍 === SEARCH RESULTS (${results.length} found) ===');
    for (Book book in results) {
      book.displayInfo();
    }
  }

  // ==================================================
  // LIBRARY STATISTICS
  // ==================================================

  void showStatistics() {
    int totalBooks = _books.length;
    int availableBooks = _books.where((book) => book.isAvailable).length;
    int borrowedBooks = _books.where((book) => !book.isAvailable).length;
    double availabilityRate = totalBooks > 0 ? (availableBooks / totalBooks) * 100 : 0.0;

    print('''
============================================================
📊 LIBRARY STATISTICS
============================================================
📚 Total Books            : $totalBooks
✅ Available Books        : $availableBooks
❌ Borrowed Books         : $borrowedBooks
📈 Availability Rate      : ${availabilityRate.toStringAsFixed(1)}%
============================================================''');
  }
}

// ======================================================
// LIBRARY APP CLASS
// HANDLES CLI MENU AND USER INTERACTION
// ======================================================

class LibraryApp {
  final Library library = Library();

  // ==================================================
  // ADD SAMPLE BOOKS (Pre-populated minimum 5 books)
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
------------------------------------------------------------
📋 MAIN MENU
------------------------------------------------------------
1. 📚 View All Books
2. ✅ View Available Books
3. ❌ View Borrowed Books
4. ➕ Add a New Book
5. 📖 Borrow a Book
6. ↩️  Return a Book
7. 🔍 Search Books by Title
8. 📊 View Library Statistics
9. 🚪 Exit
------------------------------------------------------------''');
  }

  // ==================================================
  // ADD NEW BOOK
  // ==================================================

  void addNewBook() {
    print('\n➕ === ADD NEW BOOK ===');

    stdout.write('Enter Book ID (e.g. B006): ');
    String id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('❌ Error: Book ID cannot be empty.');
      return;
    }

    if (library.findBookById(id) != null) {
      print('❌ Error: A book with ID "$id" already exists.');
      return;
    }

    stdout.write('Enter Book Title: ');
    String title = stdin.readLineSync()?.trim() ?? '';

    if (title.isEmpty) {
      print('❌ Error: Book title cannot be empty.');
      return;
    }

    stdout.write('Enter Author Name: ');
    String author = stdin.readLineSync()?.trim() ?? '';

    if (author.isEmpty) {
      print('❌ Error: Author name cannot be empty.');
      return;
    }

    stdout.write('Enter Publication Year (e.g. 2021): ');
    String yearInput = stdin.readLineSync()?.trim() ?? '';
    int? year = int.tryParse(yearInput);

    if (year == null || year <= 0 || year > DateTime.now().year) {
      print('❌ Error: Please enter a valid publication year (between 1 and ${DateTime.now().year}).');
      return;
    }

    Book newBook = Book(id, title, author, year);
    library.addBook(newBook);
  }

  // ==================================================
  // RUN APPLICATION
  // ==================================================

  void run() {
    print('''
============================================================
📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚
============================================================''');

    // Pre-populate 5 sample books
    addSampleBooks();

    bool isRunning = true;

    while (isRunning) {
      displayMenu();
      stdout.write('Enter your choice (1-9): ');

      String input = stdin.readLineSync()?.trim() ?? '';
      int? choice = int.tryParse(input);

      if (choice == null) {
        print('\n❌ Invalid input! Please enter a number from 1 to 9.');
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
            print('❌ Error: Book ID cannot be empty.');
          } else {
            library.borrowBook(id);
          }
          break;

        case 6:
          stdout.write('\nEnter Book ID to return: ');
          String id = stdin.readLineSync()?.trim() ?? '';

          if (id.isEmpty) {
            print('❌ Error: Book ID cannot be empty.');
          } else {
            library.returnBook(id);
          }
          break;

        case 7:
          stdout.write('\nEnter book title to search: ');
          String title = stdin.readLineSync()?.trim() ?? '';

          if (title.isEmpty) {
            print('❌ Error: Search query cannot be empty.');
          } else {
            library.searchBook(title);
          }
          break;

        case 8:
          library.showStatistics();
          break;

        case 9:
          print('\n============================================================');
          print('🙏 Thank you for using the Library Management System!');
          print('👋 Goodbye!');
          print('============================================================');
          isRunning = false;
          break;

        default:
          print('\n❌ Invalid choice! Please select a number from 1 to 9.');
      }
    }
  }
}

// ======================================================
// MAIN ENTRY POINT
// ======================================================

void main() {
  LibraryApp app = LibraryApp();
  app.run();
}
