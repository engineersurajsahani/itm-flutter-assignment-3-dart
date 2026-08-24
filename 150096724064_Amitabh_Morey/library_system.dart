import 'dart:io';

// ============================================================================
// 1. CUSTOM EXCEPTIONS (Exception Handling)
// ============================================================================

/// Base exception for all library-related errors.
class LibraryException implements Exception {
  final String message;
  LibraryException(this.message);

  @override
  String toString() => 'LibraryException: $message';
}

/// Thrown when a requested book ID does not exist in the catalog.
class BookNotFoundException extends LibraryException {
  BookNotFoundException(String id) : super('Book with ID "$id" was not found in the library catalog.');
}

/// Thrown when attempting to borrow a book that is already borrowed.
class BookAlreadyBorrowedException extends LibraryException {
  BookAlreadyBorrowedException(String title) : super('Book "$title" is currently unavailable / already borrowed.');
}

/// Thrown when attempting to return a book that was not borrowed.
class BookNotBorrowedException extends LibraryException {
  BookNotBorrowedException(String title) : super('Book "$title" is already in the library and was not borrowed.');
}

/// Thrown when user input is invalid or improperly formatted.
class InvalidInputException extends LibraryException {
  InvalidInputException(String details) : super('Invalid input: $details');
}

// ============================================================================
// 2. MIXIN (Interface & Reusable Behavior)
// ============================================================================

/// Mixin to provide audit and timestamp tracking functionality for library items.
mixin Trackable {
  DateTime? _dateAdded;
  DateTime? _lastModified;

  void recordAdded() {
    _dateAdded = DateTime.now();
    _lastModified = DateTime.now();
  }

  void recordModified() {
    _lastModified = DateTime.now();
  }

  String get trackingInfo {
    final addedStr = _dateAdded != null ? _dateAdded!.toIso8601String().split('T').first : 'Unknown';
    final modStr = _lastModified != null ? _lastModified!.toIso8601String().split('T').first : 'Unknown';
    return 'Added: $addedStr | Last Updated: $modStr';
  }
}

// ============================================================================
// 3. ABSTRACT CLASS (Abstraction & Contract)
// ============================================================================

/// Abstract class representing a generic item in a library.
/// Enforces contract methods for borrowing, returning, and displaying information.
abstract class LibraryItem {
  String get id;
  String get title;
  bool get isAvailable;

  /// Attempts to borrow the item. Returns true if successful, false otherwise.
  bool borrowItem();

  /// Attempts to return the item. Returns true if successful, false otherwise.
  bool returnItem();

  /// Displays detailed information about the library item.
  void displayInfo();
}

// ============================================================================
// 4. BOOK CLASS (Inheritance, Encapsulation, Method Overriding, Polymorphism)
// ============================================================================

/// Represents a physical or digital Book in the library.
/// Inherits from [LibraryItem] and mixes in [Trackable].
class Book extends LibraryItem with Trackable {
  // Private fields (Encapsulation)
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  // Parameterized Constructor
  Book({
    required String id,
    required String title,
    required String author,
    required int year,
    bool isAvailable = true,
  })  : _id = id.trim(),
        _title = title.trim(),
        _author = author.trim(),
        _year = year,
        _isAvailable = isAvailable {
    recordAdded();
  }

  // Factory Constructor for convenient instantiation with validation
  factory Book.create({
    required String id,
    required String title,
    required String author,
    required int year,
  }) {
    if (id.trim().isEmpty) throw InvalidInputException('Book ID cannot be empty.');
    if (title.trim().isEmpty) throw InvalidInputException('Title cannot be empty.');
    if (author.trim().isEmpty) throw InvalidInputException('Author cannot be empty.');
    if (year < 0 || year > DateTime.now().year + 1) {
      throw InvalidInputException('Year must be a valid four-digit year (up to ${DateTime.now().year + 1}).');
    }
    return Book(
      id: id.trim(),
      title: title.trim(),
      author: author.trim(),
      year: year,
      isAvailable: true,
    );
  }

  // --- Getters & Setters (Encapsulation) ---

  @override
  String get id => _id;

  set id(String newId) {
    if (newId.trim().isEmpty) {
      throw InvalidInputException('Book ID cannot be empty.');
    }
    _id = newId.trim();
    recordModified();
  }

  @override
  String get title => _title;

  set title(String newTitle) {
    if (newTitle.trim().isEmpty) {
      throw InvalidInputException('Title cannot be empty.');
    }
    _title = newTitle.trim();
    recordModified();
  }

  String get author => _author;

  set author(String newAuthor) {
    if (newAuthor.trim().isEmpty) {
      throw InvalidInputException('Author cannot be empty.');
    }
    _author = newAuthor.trim();
    recordModified();
  }

  int get year => _year;

  set year(int newYear) {
    if (newYear < 0 || newYear > DateTime.now().year + 1) {
      throw InvalidInputException('Invalid publication year.');
    }
    _year = newYear;
    recordModified();
  }

  @override
  bool get isAvailable => _isAvailable;

  set isAvailable(bool status) {
    _isAvailable = status;
    recordModified();
  }

  // --- Abstract Method Implementations (Polymorphism & Method Overriding) ---

  @override
  bool borrowItem() {
    if (!_isAvailable) {
      return false;
    }
    _isAvailable = false;
    recordModified();
    return true;
  }

  @override
  bool returnItem() {
    if (_isAvailable) {
      return false;
    }
    _isAvailable = true;
    recordModified();
    return true;
  }

  @override
  void displayInfo() {
    final statusText = _isAvailable ? '✅ Available' : '❌ Borrowed';
    print('📚 ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $statusText');
  }

  @override
  String toString() {
    final statusText = _isAvailable ? 'Available' : 'Borrowed';
    return 'Book[ID: $_id, Title: "$_title", Author: "$_author", Year: $_year, Status: $statusText]';
  }
}

// ============================================================================
// 5. LIBRARY CLASS (Collections, Generics & Business Logic)
// ============================================================================

/// Manages the collection of books and operations like adding, borrowing,
/// returning, searching, and calculating statistics.
class Library {
  // Private collection of books (Generics)
  final List<Book> _books = [];

  Library() {
    populateSampleData();
  }

  /// Read-only access to all books
  List<Book> get allBooks => List.unmodifiable(_books);

  /// Pre-populates the library with at least 5 standard books.
  void populateSampleData() {
    final sampleBooks = [
      Book(id: 'B001', title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', year: 1925),
      Book(id: 'B002', title: '1984', author: 'George Orwell', year: 1949),
      Book(id: 'B003', title: 'To Kill a Mockingbird', author: 'Harper Lee', year: 1960),
      Book(id: 'B004', title: 'Pride and Prejudice', author: 'Jane Austen', year: 1813),
      Book(id: 'B005', title: 'The Catcher in the Rye', author: 'J.D. Salinger', year: 1951),
    ];
    for (final book in sampleBooks) {
      addBook(book);
    }
  }

  /// Adds a new book to the library catalog.
  void addBook(Book book) {
    if (_books.any((b) => b.id.toLowerCase() == book.id.toLowerCase())) {
      throw InvalidInputException('A book with ID "${book.id}" already exists.');
    }
    _books.add(book);
  }

  /// Returns a book by its unique ID (case-insensitive), or null if not found.
  Book? findBookById(String id) {
    try {
      return _books.firstWhere((b) => b.id.toLowerCase() == id.trim().toLowerCase());
    } catch (_) {
      return null;
    }
  }

  /// Returns all available books.
  List<Book> getAvailableBooks() {
    return _books.where((b) => b.isAvailable).toList();
  }

  /// Returns all borrowed books.
  List<Book> getBorrowedBooks() {
    return _books.where((b) => !b.isAvailable).toList();
  }

  /// Searches books by title with case-insensitive partial matching.
  List<Book> searchBooksByTitle(String query) {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) return [];
    return _books.where((b) => b.title.toLowerCase().contains(cleanQuery)).toList();
  }

  /// Borrows a book by ID. Throws exceptions for invalid states.
  void borrowBook(String id) {
    final book = findBookById(id);
    if (book == null) {
      throw BookNotFoundException(id);
    }
    if (!book.isAvailable) {
      throw BookAlreadyBorrowedException(book.title);
    }
    final success = book.borrowItem();
    if (!success) {
      throw LibraryException('Unable to borrow book "${book.title}".');
    }
  }

  /// Returns a book by ID. Throws exceptions for invalid states.
  void returnBook(String id) {
    final book = findBookById(id);
    if (book == null) {
      throw BookNotFoundException(id);
    }
    if (book.isAvailable) {
      throw BookNotBorrowedException(book.title);
    }
    final success = book.returnItem();
    if (!success) {
      throw LibraryException('Unable to return book "${book.title}".');
    }
  }

  /// Calculates statistics including counts and availability percentage.
  Map<String, dynamic> getStatistics() {
    final total = _books.length;
    final available = getAvailableBooks().length;
    final borrowed = getBorrowedBooks().length;
    final percentage = total > 0 ? ((available / total) * 100) : 0.0;

    return {
      'total': total,
      'available': available,
      'borrowed': borrowed,
      'percentage': percentage,
    };
  }

  /// Displays all books in a structured format.
  void displayAllBooks() {
    print('\n📚 === ALL BOOKS ===');
    if (_books.isEmpty) {
      print('No books found in the library.');
      return;
    }
    for (final book in _books) {
      book.displayInfo();
    }
    final stats = getStatistics();
    print('📊 Total Books: ${stats['total']}');
    print('✅ Available: ${stats['available']}');
    print('❌ Borrowed: ${stats['borrowed']}');
  }

  /// Displays only currently available books.
  void displayAvailableBooks() {
    print('\n✅ === AVAILABLE BOOKS ===');
    final availableList = getAvailableBooks();
    if (availableList.isEmpty) {
      print('No books are currently available.');
      return;
    }
    for (final book in availableList) {
      book.displayInfo();
    }
    print('📊 Available Books Count: ${availableList.length}');
  }

  /// Displays only currently borrowed books.
  void displayBorrowedBooks() {
    print('\n❌ === BORROWED BOOKS ===');
    final borrowedList = getBorrowedBooks();
    if (borrowedList.isEmpty) {
      print('No books are currently borrowed.');
      return;
    }
    for (final book in borrowedList) {
      book.displayInfo();
    }
    print('📊 Borrowed Books Count: ${borrowedList.length}');
  }

  /// Displays library statistical summary.
  void displayStatistics() {
    final stats = getStatistics();
    final double pct = stats['percentage'] as double;
    print('\n============================================================');
    print('📊 === LIBRARY STATISTICS ===');
    print('============================================================');
    print('📚 Total Books in Catalog : ${stats['total']}');
    print('✅ Available Books        : ${stats['available']}');
    print('❌ Borrowed Books         : ${stats['borrowed']}');
    print('📈 Availability Ratio     : ${pct.toStringAsFixed(1)}%');
    print('============================================================');
  }
}

// ============================================================================
// 6. LIBRARY APP CLASS (CLI Flow, Menu, User Interaction, Validation)
// ============================================================================

/// Controls the user interface, reading inputs from stdin, displaying menus,
/// and executing library commands.
class LibraryApp {
  final Library _library = Library();

  /// Starts the interactive command line application loop.
  void start() {
    _printWelcomeBanner();

    bool running = true;
    while (running) {
      _printMenu();
      stdout.write('Enter your choice (1-9): ');
      final choice = stdin.readLineSync()?.trim() ?? '';

      switch (choice) {
        case '1':
          _handleViewAllBooks();
          break;
        case '2':
          _handleViewAvailableBooks();
          break;
        case '3':
          _handleViewBorrowedBooks();
          break;
        case '4':
          _handleAddBook();
          break;
        case '5':
          _handleBorrowBook();
          break;
        case '6':
          _handleReturnBook();
          break;
        case '7':
          _handleSearchBooks();
          break;
        case '8':
          _handleViewStatistics();
          break;
        case '9':
          running = false;
          _printExitBanner();
          break;
        default:
          print('\n⚠️ Invalid choice! Please enter a number between 1 and 9.');
          _promptContinue();
      }
    }
  }

  void _printWelcomeBanner() {
    print('============================================================');
    print('📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚');
    print('============================================================');
  }

  void _printMenu() {
    print('\n------------------------------------------------------------');
    print('📋 MAIN MENU');
    print('------------------------------------------------------------');
    print('1. 📚 View All Books');
    print('2. ✅ View Available Books');
    print('3. ❌ View Borrowed Books');
    print('4. ➕ Add a New Book');
    print('5. 📖 Borrow a Book');
    print('6. ↩️  Return a Book');
    print('7. 🔍 Search Books by Title');
    print('8. 📊 View Library Statistics');
    print('9. 🚪 Exit');
    print('------------------------------------------------------------');
  }

  void _printExitBanner() {
    print('\n============================================================');
    print('👋 Thank you for using the Library Management System!');
    print('✨ Have a wonderful day!');
    print('============================================================\n');
  }

  void _promptContinue() {
    stdout.write('\nPress Enter to continue...');
    stdin.readLineSync();
  }

  // --- Handlers for each menu option ---

  void _handleViewAllBooks() {
    _library.displayAllBooks();
    _promptContinue();
  }

  void _handleViewAvailableBooks() {
    _library.displayAvailableBooks();
    _promptContinue();
  }

  void _handleViewBorrowedBooks() {
    _library.displayBorrowedBooks();
    _promptContinue();
  }

  void _handleAddBook() {
    print('\n➕ === ADD A NEW BOOK ===');
    try {
      stdout.write('Enter Book ID (e.g. B006): ');
      final id = stdin.readLineSync()?.trim() ?? '';
      if (id.isEmpty) throw InvalidInputException('Book ID cannot be empty.');

      stdout.write('Enter Book Title: ');
      final title = stdin.readLineSync()?.trim() ?? '';
      if (title.isEmpty) throw InvalidInputException('Title cannot be empty.');

      stdout.write('Enter Author Name: ');
      final author = stdin.readLineSync()?.trim() ?? '';
      if (author.isEmpty) throw InvalidInputException('Author cannot be empty.');

      stdout.write('Enter Publication Year: ');
      final yearInput = stdin.readLineSync()?.trim() ?? '';
      final year = int.tryParse(yearInput);
      if (year == null) {
        throw InvalidInputException('Publication Year must be a valid integer number.');
      }

      final newBook = Book.create(
        id: id,
        title: title,
        author: author,
        year: year,
      );

      _library.addBook(newBook);
      print('\n🎉 Success: Book "${newBook.title}" (ID: ${newBook.id}) was successfully added!');
    } on LibraryException catch (e) {
      print('\n❌ Error: ${e.message}');
    } catch (e) {
      print('\n❌ Unexpected Error: $e');
    }
    _promptContinue();
  }

  void _handleBorrowBook() {
    print('\n📖 === BORROW A BOOK ===');
    stdout.write('Enter Book ID to borrow: ');
    final id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('❌ Error: Book ID cannot be empty.');
      _promptContinue();
      return;
    }

    try {
      final book = _library.findBookById(id);
      _library.borrowBook(id);
      print('\n🎉 Success: You have successfully borrowed "${book?.title ?? id}"!');
    } on LibraryException catch (e) {
      print('\n❌ Error: ${e.message}');
    } catch (e) {
      print('\n❌ Unexpected Error: $e');
    }
    _promptContinue();
  }

  void _handleReturnBook() {
    print('\n↩️ === RETURN A BOOK ===');
    stdout.write('Enter Book ID to return: ');
    final id = stdin.readLineSync()?.trim() ?? '';

    if (id.isEmpty) {
      print('❌ Error: Book ID cannot be empty.');
      _promptContinue();
      return;
    }

    try {
      final book = _library.findBookById(id);
      _library.returnBook(id);
      print('\n🎉 Success: Book "${book?.title ?? id}" was successfully returned!');
    } on LibraryException catch (e) {
      print('\n❌ Error: ${e.message}');
    } catch (e) {
      print('\n❌ Unexpected Error: $e');
    }
    _promptContinue();
  }

  void _handleSearchBooks() {
    print('\n🔍 === SEARCH BOOKS BY TITLE ===');
    stdout.write('Enter search query: ');
    final query = stdin.readLineSync()?.trim() ?? '';

    if (query.isEmpty) {
      print('❌ Error: Search keyword cannot be empty.');
      _promptContinue();
      return;
    }

    final results = _library.searchBooksByTitle(query);
    if (results.isEmpty) {
      print('\n🔍 No books matching "$query" found in the catalog.');
    } else {
      print('\n🔍 Found ${results.length} matching result(s):');
      for (final book in results) {
        book.displayInfo();
      }
    }
    _promptContinue();
  }

  void _handleViewStatistics() {
    _library.displayStatistics();
    _promptContinue();
  }
}

// ============================================================================
// 7. MAIN FUNCTION (Entry Point)
// ============================================================================

void main() {
  final app = LibraryApp();
  app.start();
}
