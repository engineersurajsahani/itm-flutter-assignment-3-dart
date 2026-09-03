import 'dart:io';

// ─────────────────────────────────────────────────────────────
//  Mixin : Searchable
//  Gives any class a simple keyword-match helper.
// ─────────────────────────────────────────────────────────────
mixin Searchable {
  bool matchesKeyword(String keyword, String text) {
    return text.toLowerCase().contains(keyword.toLowerCase().trim());
  }
}

// ─────────────────────────────────────────────────────────────
//  Abstract class : LibraryItem
//  Defines the contract every library item must follow.
// ─────────────────────────────────────────────────────────────
abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}

// ─────────────────────────────────────────────────────────────
//  Class : Book
//  Extends LibraryItem and mixes in Searchable.
//  All fields are private; exposed via getters / setters.
// ─────────────────────────────────────────────────────────────
class Book extends LibraryItem with Searchable {
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  Book({
    required String id,
    required String title,
    required String author,
    required int year,
    bool isAvailable = true,
  })  : _id = id,
        _title = title,
        _author = author,
        _year = year,
        _isAvailable = isAvailable;

  // ── Getters ──
  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  // ── Setters ──
  set title(String value) {
    if (value.trim().isEmpty) throw ArgumentError('Title cannot be empty.');
    _title = value.trim();
  }

  set author(String value) {
    if (value.trim().isEmpty) throw ArgumentError('Author cannot be empty.');
    _author = value.trim();
  }

  set year(int value) {
    if (value < 1000 || value > DateTime.now().year) {
      throw ArgumentError('Year out of valid range.');
    }
    _year = value;
  }

  // ── Overridden methods (Method Overriding + Polymorphism) ──
  @override
  void borrowItem() {
    if (!_isAvailable) {
      print('  ⚠️  Sorry, "$_title" is already borrowed.');
      return;
    }
    _isAvailable = false;
    print('  ✅ "$_title" has been borrowed successfully.');
  }

  @override
  void returnItem() {
    if (_isAvailable) {
      print('  ⚠️  "$_title" was not borrowed.');
      return;
    }
    _isAvailable = true;
    print('  ✅ "$_title" has been returned successfully. Thank you!');
  }

  @override
  void displayInfo() {
    final status = _isAvailable ? '✅ Available' : '❌ Borrowed';
    print(
        '  📚 ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $status');
  }

  // Delegating search to the mixin
  bool titleMatchesKeyword(String keyword) => matchesKeyword(keyword, _title);
}

// ─────────────────────────────────────────────────────────────
//  Class : Library
//  Manages the collection and all business operations.
// ─────────────────────────────────────────────────────────────
class Library {
  final List<Book> _books = [];
  int _idCounter = 1;

  // ── Seed with sample data ──
  Library() {
    _addSample('The Great Gatsby', 'F. Scott Fitzgerald', 1925);
    _addSample('1984', 'George Orwell', 1949);
    _addSample('To Kill a Mockingbird', 'Harper Lee', 1960);
    _addSample('The Alchemist', 'Paulo Coelho', 1988);
    _addSample('Harry Potter and the Sorcerer\'s Stone', 'J.K. Rowling', 1997);
    _addSample('The Da Vinci Code', 'Dan Brown', 2003);
  }

  // Private helper to build a formatted ID
  String _nextId() => 'B${_idCounter.toString().padLeft(3, '0')}';

  void _addSample(String title, String author, int year) {
    _books.add(Book(id: _nextId(), title: title, author: author, year: year));
    _idCounter++;
  }

  // ─── Public Operations ───────────────────────────────────

  void addBook(String title, String author, int year) {
    final book = Book(
      id: _nextId(),
      title: title,
      author: author,
      year: year,
    );
    _books.add(book);
    _idCounter++;
    print('\n  ✅ Book added successfully!');
    book.displayInfo();
  }

  void viewAllBooks() {
    if (_books.isEmpty) {
      print('  📭 No books in the library yet.');
      return;
    }
    print('  📚 === ALL BOOKS ===');
    for (var book in _books) {
      book.displayInfo();
    }
    _printSummary();
  }

  void viewAvailableBooks() {
    final available = _books.where((b) => b.isAvailable).toList();
    if (available.isEmpty) {
      print('  📭 No books are currently available.');
      return;
    }
    print('  ✅ === AVAILABLE BOOKS ===');
    for (var book in available) {
      book.displayInfo();
    }
    print('\n  📊 Available: ${available.length}');
  }

  void viewBorrowedBooks() {
    final borrowed = _books.where((b) => !b.isAvailable).toList();
    if (borrowed.isEmpty) {
      print('  📭 No books are currently borrowed.');
      return;
    }
    print('  ❌ === BORROWED BOOKS ===');
    for (var book in borrowed) {
      book.displayInfo();
    }
    print('\n  📊 Borrowed: ${borrowed.length}');
  }

  void borrowBook(String id) {
    final book = _findById(id);
    if (book == null) {
      print('  ❌ Book with ID "$id" not found.');
      return;
    }
    book.borrowItem(); // Runtime polymorphism
  }

  void returnBook(String id) {
    final book = _findById(id);
    if (book == null) {
      print('  ❌ Book with ID "$id" not found.');
      return;
    }
    book.returnItem(); // Runtime polymorphism
  }

  void searchByTitle(String keyword) {
    final results = _books.where((b) => b.titleMatchesKeyword(keyword)).toList();
    if (results.isEmpty) {
      print('  🔍 No books found matching "$keyword".');
      return;
    }
    print('  🔍 Search results for "$keyword":');
    for (var book in results) {
      book.displayInfo();
    }
    print('\n  📊 Found: ${results.length} book(s)');
  }

  void showStatistics() {
    final total = _books.length;
    final available = _books.where((b) => b.isAvailable).length;
    final borrowed = total - available;
    final pct = total == 0 ? 0.0 : (available / total * 100);

    print('  📊 === LIBRARY STATISTICS ===');
    print('  📚 Total Books    : $total');
    print('  ✅ Available      : $available');
    print('  ❌ Borrowed       : $borrowed');
    print('  📈 Availability   : ${pct.toStringAsFixed(1)}%');
  }

  // ─── Private helpers ─────────────────────────────────────

  Book? _findById(String id) {
    try {
      return _books.firstWhere(
        (b) => b.id.toLowerCase() == id.toLowerCase().trim(),
      );
    } catch (_) {
      return null;
    }
  }

  void _printSummary() {
    final total = _books.length;
    final available = _books.where((b) => b.isAvailable).length;
    print('\n  📊 Total Books: $total  |  ✅ Available: $available  |  ❌ Borrowed: ${total - available}');
  }
}

// ─────────────────────────────────────────────────────────────
//  Class : LibraryApp
//  Drives the main menu loop and handles user interaction.
// ─────────────────────────────────────────────────────────────
class LibraryApp {
  final Library _library = Library();

  void run() {
    _printWelcome();
    while (true) {
      _printMenu();
      final choice = _prompt('Enter your choice (1-9)').trim();

      switch (choice) {
        case '1':
          _sectionHeader('VIEW ALL BOOKS');
          _library.viewAllBooks();
          break;
        case '2':
          _sectionHeader('AVAILABLE BOOKS');
          _library.viewAvailableBooks();
          break;
        case '3':
          _sectionHeader('BORROWED BOOKS');
          _library.viewBorrowedBooks();
          break;
        case '4':
          _sectionHeader('ADD A NEW BOOK');
          _handleAddBook();
          break;
        case '5':
          _sectionHeader('BORROW A BOOK');
          _handleBorrow();
          break;
        case '6':
          _sectionHeader('RETURN A BOOK');
          _handleReturn();
          break;
        case '7':
          _sectionHeader('SEARCH BOOKS BY TITLE');
          _handleSearch();
          break;
        case '8':
          _sectionHeader('LIBRARY STATISTICS');
          _library.showStatistics();
          break;
        case '9':
          print('\n  🚪 Thank you for using the Library System. Goodbye!\n');
          exit(0);
        default:
          print('\n  ⚠️  Invalid choice. Please enter a number between 1 and 9.');
      }

      _waitForEnter();
    }
  }

  // ─── Input helpers ───────────────────────────────────────

  void _handleAddBook() {
    final title = _prompt('  Enter book title');
    if (title.trim().isEmpty) {
      print('  ❌ Title cannot be empty.');
      return;
    }

    final author = _prompt('  Enter author name');
    if (author.trim().isEmpty) {
      print('  ❌ Author name cannot be empty.');
      return;
    }

    final yearStr = _prompt('  Enter publication year');
    final year = int.tryParse(yearStr.trim());
    if (year == null || year < 1000 || year > DateTime.now().year) {
      print('  ❌ Please enter a valid year (1000 – ${DateTime.now().year}).');
      return;
    }

    _library.addBook(title.trim(), author.trim(), year);
  }

  void _handleBorrow() {
    _library.viewAvailableBooks();
    final id = _prompt('\n  Enter the Book ID to borrow');
    if (id.trim().isEmpty) {
      print('  ❌ Book ID cannot be empty.');
      return;
    }
    _library.borrowBook(id.trim());
  }

  void _handleReturn() {
    _library.viewBorrowedBooks();
    final id = _prompt('\n  Enter the Book ID to return');
    if (id.trim().isEmpty) {
      print('  ❌ Book ID cannot be empty.');
      return;
    }
    _library.returnBook(id.trim());
  }

  void _handleSearch() {
    final keyword = _prompt('  Enter title keyword to search');
    if (keyword.trim().isEmpty) {
      print('  ❌ Search keyword cannot be empty.');
      return;
    }
    _library.searchByTitle(keyword.trim());
  }

  // ─── UI helpers ──────────────────────────────────────────

  String _prompt(String message) {
    stdout.write('\n  $message: ');
    return stdin.readLineSync() ?? '';
  }

  void _waitForEnter() {
    stdout.write('\n  Press Enter to continue...');
    stdin.readLineSync();
  }

  void _sectionHeader(String title) {
    print('\n  ${'-' * 60}');
    print('  $title');
    print('  ${'-' * 60}');
  }

  void _printWelcome() {
    print('\n  ${'=' * 60}');
    print('  📚  WELCOME TO THE LIBRARY MANAGEMENT SYSTEM  📚');
    print('  ${'=' * 60}\n');
  }

  void _printMenu() {
    print('\n  ${'-' * 60}');
    print('  📋  MAIN MENU');
    print('  ${'-' * 60}');
    print('  1. 📚  View All Books');
    print('  2. ✅  View Available Books');
    print('  3. ❌  View Borrowed Books');
    print('  4. ➕  Add a New Book');
    print('  5. 📖  Borrow a Book');
    print('  6. ↩️   Return a Book');
    print('  7. 🔍  Search Books by Title');
    print('  8. 📊  View Library Statistics');
    print('  9. 🚪  Exit');
    print('  ${'-' * 60}');
  }
}

// ─────────────────────────────────────────────────────────────
//  Entry point
// ─────────────────────────────────────────────────────────────
void main() {
  LibraryApp().run();
}
