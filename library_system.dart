import 'dart:io';

// Abstraction
abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}

// Interface (Mixin) requirement
mixin Printable {
  void printFormatted(String message) {
    print('------------------------------------------------------------');
    print(message);
    print('------------------------------------------------------------');
  }
}

// Encapsulation and Inheritance
class Book extends LibraryItem {
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  // Constructor with named and positional params
  Book(this._id, this._title, this._author, this._year, {bool isAvailable = true}) 
      : _isAvailable = isAvailable;

  // Getters
  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  // Setters
  set isAvailable(bool status) {
    _isAvailable = status;
  }

  // Method Overriding & Polymorphism
  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('✅ Successfully borrowed "$_title".');
    } else {
      print('❌ Sorry, "$_title" is currently not available.');
    }
  }

  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('✅ Successfully returned "$_title".');
    } else {
      print('⚠️ "$_title" was not borrowed.');
    }
  }

  @override
  void displayInfo() {
    String status = _isAvailable ? '✅ Available' : '❌ Borrowed';
    print('📚 ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $status');
  }
}

// Library Class
class Library with Printable {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
    print('✅ Book "${book.title}" added to the library.');
  }

  void displayAllBooks() {
    if (_books.isEmpty) {
      print('No books in the library.');
      return;
    }
    print('📚 === ALL BOOKS === 📚');
    for (var book in _books) {
      book.displayInfo();
    }
  }

  void displayAvailableBooks() {
    var availableBooks = _books.where((book) => book.isAvailable).toList();
    if (availableBooks.isEmpty) {
      print('No available books.');
      return;
    }
    print('✅ === AVAILABLE BOOKS === ✅');
    for (var book in availableBooks) {
      book.displayInfo();
    }
  }

  void displayBorrowedBooks() {
    var borrowedBooks = _books.where((book) => !book.isAvailable).toList();
    if (borrowedBooks.isEmpty) {
      print('No borrowed books.');
      return;
    }
    print('❌ === BORROWED BOOKS === ❌');
    for (var book in borrowedBooks) {
      book.displayInfo();
    }
  }

  void borrowBook(String id) {
    try {
      var book = _books.firstWhere((b) => b.id.toLowerCase() == id.toLowerCase());
      book.borrowItem();
    } catch (e) {
      print('❌ Book with ID "$id" not found.');
    }
  }

  void returnBook(String id) {
    try {
      var book = _books.firstWhere((b) => b.id.toLowerCase() == id.toLowerCase());
      book.returnItem();
    } catch (e) {
      print('❌ Book with ID "$id" not found.');
    }
  }

  void searchBooks(String title) {
    var results = _books.where((b) => b.title.toLowerCase().contains(title.toLowerCase())).toList();
    if (results.isEmpty) {
      print('❌ No books found matching "$title".');
    } else {
      print('🔍 === SEARCH RESULTS === 🔍');
      for (var book in results) {
        book.displayInfo();
      }
    }
  }

  void displayStatistics() {
    int total = _books.length;
    int available = _books.where((b) => b.isAvailable).length;
    int borrowed = total - available;
    double percentage = total > 0 ? (available / total) * 100 : 0;

    print('📊 Total Books: $total');
    print('✅ Available: $available');
    print('❌ Borrowed: $borrowed');
    print('📊 Availability Percentage: ${percentage.toStringAsFixed(2)}%');
  }
}

// LibraryApp Class
class LibraryApp {
  final Library _library = Library();

  LibraryApp() {
    // Pre-populate with 5 sample books
    _library.addBook(Book('B001', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925));
    _library.addBook(Book('B002', '1984', 'George Orwell', 1949));
    _library.addBook(Book('B003', 'To Kill a Mockingbird', 'Harper Lee', 1960));
    _library.addBook(Book('B004', 'Pride and Prejudice', 'Jane Austen', 1813));
    _library.addBook(Book('B005', 'The Catcher in the Rye', 'J.D. Salinger', 1951));
    print('\n' * 20); // Clear screen after initial output
  }

  void run() {
    bool running = true;
    while (running) {
      print('\n============================================================');
      print('         📚 WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 📚        ');
      print('============================================================');
      print('------------------------------------------------------------');
      print('                      📋 MAIN MENU                      ');
      print('------------------------------------------------------------');
      print('1. 📚 View All Books');
      print('2. ✅ View Available Books');
      print('3. ❌ View Borrowed Books');
      print('4. ➕ Add a New Book');
      print('5. 📖 Borrow a Book');
      print('6. ↩️ Return a Book');
      print('7. 🔍 Search Books by Title');
      print('8. 📊 View Library Statistics');
      print('9. 🚪 Exit');
      print('------------------------------------------------------------');
      stdout.write('Enter your choice (1-9): ');

      String? input = stdin.readLineSync();
      print(''); // Empty line for readability
      
      switch (input) {
        case '1':
          _library.displayAllBooks();
          break;
        case '2':
          _library.displayAvailableBooks();
          break;
        case '3':
          _library.displayBorrowedBooks();
          break;
        case '4':
          _addBookFlow();
          break;
        case '5':
          stdout.write('Enter Book ID to borrow: ');
          String? id = stdin.readLineSync();
          if (id != null && id.isNotEmpty) {
            _library.borrowBook(id);
          } else {
            print('❌ Invalid ID.');
          }
          break;
        case '6':
          stdout.write('Enter Book ID to return: ');
          String? id = stdin.readLineSync();
          if (id != null && id.isNotEmpty) {
            _library.returnBook(id);
          } else {
            print('❌ Invalid ID.');
          }
          break;
        case '7':
          stdout.write('Enter Book Title to search: ');
          String? title = stdin.readLineSync();
          if (title != null && title.isNotEmpty) {
            _library.searchBooks(title);
          } else {
            print('❌ Invalid title.');
          }
          break;
        case '8':
          _library.displayStatistics();
          break;
        case '9':
          running = false;
          print('🚪 Exiting... Thank you for using the Library Management System!');
          continue;
        default:
          print('❌ Invalid choice. Please enter a number between 1 and 9.');
      }
      
      if (running) {
        stdout.write('\nPress Enter to continue...');
        stdin.readLineSync();
      }
    }
  }

  void _addBookFlow() {
    stdout.write('Enter Book ID (e.g., B006): ');
    String id = stdin.readLineSync()?.trim() ?? '';
    
    stdout.write('Enter Book Title: ');
    String title = stdin.readLineSync()?.trim() ?? '';
    
    stdout.write('Enter Book Author: ');
    String author = stdin.readLineSync()?.trim() ?? '';
    
    stdout.write('Enter Publication Year: ');
    String yearStr = stdin.readLineSync()?.trim() ?? '';
    
    if (id.isEmpty || title.isEmpty || author.isEmpty || yearStr.isEmpty) {
      print('❌ All fields are required to add a book.');
      return;
    }
    
    try {
      int year = int.parse(yearStr);
      _library.addBook(Book(id, title, author, year));
    } catch (e) {
      print('❌ Invalid year. Please enter a valid number.');
    }
  }
}

// Main Function
void main() {
  LibraryApp app = LibraryApp();
  app.run();
}

