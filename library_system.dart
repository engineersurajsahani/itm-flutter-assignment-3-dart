import 'dart:io';

/// Defines the common behaviour of every item that may be loaned by a library.
abstract class LibraryItem {
  bool borrowItem();
  bool returnItem();
  void displayInfo();
}

/// Adds a reusable display label to library items.
mixin Identifiable {
  String get id;
}

/// A single book held by the library.
class Book extends LibraryItem with Identifiable {
  final String _id;
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
  }) : _id = id,
       _title = _requireText(title, 'Title'),
       _author = _requireText(author, 'Author'),
       _year = _requireYear(year),
       _isAvailable = isAvailable;

  @override
  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  set title(String value) => _title = _requireText(value, 'Title');
  set author(String value) => _author = _requireText(value, 'Author');
  set year(int value) => _year = _requireYear(value);

  static String _requireText(String value, String fieldName) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('$fieldName cannot be empty.');
    }
    return trimmed;
  }

  static int _requireYear(int value) {
    final currentYear = DateTime.now().year;
    if (value < 0 || value > currentYear) {
      throw ArgumentError('Year must be between 0 and $currentYear.');
    }
    return value;
  }

  @override
  bool borrowItem() {
    if (!_isAvailable) return false;
    _isAvailable = false;
    return true;
  }

  @override
  bool returnItem() {
    if (_isAvailable) return false;
    _isAvailable = true;
    return true;
  }

  @override
  void displayInfo() {
    final status = _isAvailable ? '✅ Available' : '❌ Borrowed';
    print(
      '📚 ID: $_id | Title: $_title | Author: $_author | '
      'Year: $_year | Status: $status',
    );
  }
}

/// Stores and operates on the collection of books.
class Library {
  final List<Book> _books = [];
  int _nextBookNumber = 1;

  List<Book> get books => List.unmodifiable(_books);
  int get totalBooks => _books.length;
  int get availableBooks => _books.where((book) => book.isAvailable).length;
  int get borrowedBooks => totalBooks - availableBooks;
  double get availabilityPercentage =>
      totalBooks == 0 ? 0 : availableBooks / totalBooks * 100;

  void addBook(Book book) {
    if (_books.any((existing) => existing.id == book.id)) {
      throw ArgumentError('A book with ID ${book.id} already exists.');
    }
    _books.add(book);
  }

  String createBookId() {
    while (_books.any(
      (book) => book.id == 'B${_nextBookNumber.toString().padLeft(3, '0')}',
    )) {
      _nextBookNumber++;
    }
    final id = 'B${_nextBookNumber.toString().padLeft(3, '0')}';
    _nextBookNumber++;
    return id;
  }

  Book? findById(String id) {
    final normalizedId = id.trim().toUpperCase();
    for (final book in _books) {
      if (book.id.toUpperCase() == normalizedId) return book;
    }
    return null;
  }

  List<Book> searchByTitle(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    return _books
        .where((book) => book.title.toLowerCase().contains(normalizedQuery))
        .toList();
  }

  bool borrowBook(String id) {
    final book = findById(id);
    return book?.borrowItem() ?? false;
  }

  bool returnBook(String id) {
    final book = findById(id);
    return book?.returnItem() ?? false;
  }
}

/// Owns the menu loop and all terminal input/output.
class LibraryApp {
  final Library _library = Library();

  LibraryApp() {
    _seedBooks();
  }

  void _seedBooks() {
    const sampleBooks = [
      ('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
      ('1984', 'George Orwell', 1949),
      ('To Kill a Mockingbird', 'Harper Lee', 1960),
      ('Pride and Prejudice', 'Jane Austen', 1813),
      ('The Hobbit', 'J.R.R. Tolkien', 1937),
    ];
    for (final sample in sampleBooks) {
      _library.addBook(
        Book(
          id: _library.createBookId(),
          title: sample.$1,
          author: sample.$2,
          year: sample.$3,
        ),
      );
    }
  }

  void start() {
    print('============================================================');
    print('📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚');
    print('============================================================');

    var running = true;
    while (running) {
      _showMenu();
      switch (_readLine('Enter your choice (1-9): ')) {
        case '1':
          _displayBooks(_library.books, 'ALL BOOKS');
          break;
        case '2':
          _displayBooks(
            _library.books.where((b) => b.isAvailable),
            'AVAILABLE BOOKS',
          );
          break;
        case '3':
          _displayBooks(
            _library.books.where((b) => !b.isAvailable),
            'BORROWED BOOKS',
          );
          break;
        case '4':
          _addBook();
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
          _showStatistics();
          break;
        case '9':
          running = false;
          print(
            '\nThank you for using the Library Management System. Goodbye!',
          );
          continue;
        default:
          print('\n❗ Invalid choice. Please enter a number from 1 to 9.');
      }
      _pause();
    }
  }

  void _showMenu() {
    print('\n------------------------------------------------------------');
    print('📋 MAIN MENU');
    print('------------------------------------------------------------');
    print(
      '1. 📚 View All Books\n2. ✅ View Available Books\n3. ❌ View Borrowed Books',
    );
    print('4. ➕ Add a New Book\n5. 📖 Borrow a Book\n6. ↩️ Return a Book');
    print(
      '7. 🔍 Search Books by Title\n8. 📊 View Library Statistics\n9. 🚪 Exit',
    );
    print('------------------------------------------------------------');
  }

  String _readLine(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()?.trim() ?? '';
  }

  void _displayBooks(Iterable<Book> books, String heading) {
    print('\n📚 === $heading ===');
    final list = books.toList();
    if (list.isEmpty) {
      print('No books found.');
      return;
    }
    for (final book in list) {
      // Runtime polymorphism: this invokes Book's override through LibraryItem.
      final LibraryItem item = book;
      item.displayInfo();
    }
  }

  void _addBook() {
    print('\n➕ === ADD A NEW BOOK ===');
    final title = _readRequired('Title: ');
    final author = _readRequired('Author: ');
    final year = _readYear();
    final book = Book(
      id: _library.createBookId(),
      title: title,
      author: author,
      year: year,
    );
    _library.addBook(book);
    print('✅ "${book.title}" added successfully with ID ${book.id}.');
  }

  String _readRequired(String prompt) {
    while (true) {
      final value = _readLine(prompt);
      if (value.isNotEmpty) return value;
      print('❗ This field cannot be empty. Please try again.');
    }
  }

  int _readYear() {
    final currentYear = DateTime.now().year;
    while (true) {
      final year = int.tryParse(_readLine('Year: '));
      if (year != null && year >= 0 && year <= currentYear) return year;
      print('❗ Enter a valid year between 0 and $currentYear.');
    }
  }

  void _borrowBook() {
    print('\n📖 === BORROW A BOOK ===');
    final id = _readRequired('Enter book ID: ');
    final book = _library.findById(id);
    if (book == null) {
      print('❗ No book found with ID $id.');
    } else if (_library.borrowBook(id)) {
      print('✅ You borrowed "${book.title}".');
    } else {
      print('❗ "${book.title}" is already borrowed.');
    }
  }

  void _returnBook() {
    print('\n↩️ === RETURN A BOOK ===');
    final id = _readRequired('Enter book ID: ');
    final book = _library.findById(id);
    if (book == null) {
      print('❗ No book found with ID $id.');
    } else if (_library.returnBook(id)) {
      print('✅ You returned "${book.title}".');
    } else {
      print('❗ "${book.title}" is already available in the library.');
    }
  }

  void _searchBooks() {
    print('\n🔍 === SEARCH BOOKS ===');
    final query = _readRequired('Enter title or part of a title: ');
    _displayBooks(_library.searchByTitle(query), 'SEARCH RESULTS');
  }

  void _showStatistics() {
    print('\n📊 === LIBRARY STATISTICS ===');
    print('📚 Total Books: ${_library.totalBooks}');
    print('✅ Available: ${_library.availableBooks}');
    print('❌ Borrowed: ${_library.borrowedBooks}');
    print(
      '📈 Availability: ${_library.availabilityPercentage.toStringAsFixed(1)}%',
    );
  }

  void _pause() => _readLine('\nPress Enter to continue...');
}

void main() {
  LibraryApp().start();
}
