import 'dart:io';


abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}


class Book extends LibraryItem {
  String _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  Book(this._id, this._title, this._author, this._year, {bool isAvailable = true})
      : _isAvailable = isAvailable;

  String get id => _id;
  String get title => _title;
  String get author => _author;
  int get year => _year;
  bool get isAvailable => _isAvailable;

  set isAvailable(bool value) {
    _isAvailable = value;
  }

  @override
  void borrowItem() {
    if (_isAvailable) {
      _isAvailable = false;
      print('Successfully borrowed "$_title".');
    } else {
      print('"$_title" is currently not available.');
    }
  }

  @override
  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('Successfully returned "$_title".');
    } else {
      print('ℹ"$_title" was not borrowed.');
    }
  }

  @override
  void displayInfo() {
    String status = _isAvailable ? ' Available' : ' Borrowed';
    print(' ID: $_id | Title: $_title | Author: $_author | Year: $_year | Status: $status');
  }
}

class Library {
  final List<Book> _books = [];

  Library() {

    _books.add(Book('B001', 'The Great Gatsby', 'F. Scott Fitzgerald', 1925));
    _books.add(Book('B002', '1984', 'George Orwell', 1949));
    _books.add(Book('B003', 'To Kill a Mockingbird', 'Harper Lee', 1960));
    _books.add(Book('B004', 'Pride and Prejudice', 'Jane Austen', 1813));
    _books.add(Book('B005', 'The Catcher in the Rye', 'J.D. Salinger', 1951));
  }

  void addBook(String title, String author, int year) {
    String id = 'B${(_books.length + 1).toString().padLeft(3, '0')}';
    _books.add(Book(id, title, author, year));
    print('Book added successfully! ID is $id');
  }

  void viewAllBooks() {
    if (_books.isEmpty) {
      print('No books in the library.');
      return;
    }
    print('\n=== ALL BOOKS ===');
    for (var book in _books) {
      book.displayInfo();
    }
  }

  void viewAvailableBooks() {
    var availableBooks = _books.where((b) => b.isAvailable).toList();
    if (availableBooks.isEmpty) {
      print('No available books.');
      return;
    }
    print('\n=== AVAILABLE BOOKS ===');
    for (var book in availableBooks) {
      book.displayInfo();
    }
  }

  void viewBorrowedBooks() {
    var borrowedBooks = _books.where((b) => !b.isAvailable).toList();
    if (borrowedBooks.isEmpty) {
      print('No borrowed books.');
      return;
    }
    print('\n === BORROWED BOOKS ===');
    for (var book in borrowedBooks) {
      book.displayInfo();
    }
  }

  void borrowBook(String id) {
    try {
      var book = _books.firstWhere((b) => b.id == id);
      book.borrowItem();
    } catch (e) {
      print('Book with ID $id not found.');
    }
  }

  void returnBook(String id) {
    try {
      var book = _books.firstWhere((b) => b.id == id);
      book.returnItem();
    } catch (e) {
      print(' Book with ID $id not found.');
    }
  }

  void searchBooksByTitle(String keyword) {
    var results = _books.where((b) => b.title.toLowerCase().contains(keyword.toLowerCase())).toList();
    if (results.isEmpty) {
      print(' No books found matching "$keyword".');
      return;
    }
    print('\n=== SEARCH RESULTS ===');
    for (var book in results) {
      book.displayInfo();
    }
  }

  void viewStatistics() {
    int total = _books.length;
    int available = _books.where((b) => b.isAvailable).length;
    int borrowed = total - available;
    double percentage = total > 0 ? (available / total) * 100 : 0;

    print('\n=== LIBRARY STATISTICS ===');
    print('Total Books: $total');
    print(' Available: $available');
    print(' Borrowed: $borrowed');
    print(' Availability: ${percentage.toStringAsFixed(2)}%');
  }
}

class LibraryApp {
  final Library _library = Library();

  void start() {
    while (true) {
      _showMenu();
      stdout.write('Enter your choice (1-9): ');
      String? input = stdin.readLineSync();
      
      switch (input) {
        case '1':
          _library.viewAllBooks();
          break;
        case '2':
          _library.viewAvailableBooks();
          break;
        case '3':
          _library.viewBorrowedBooks();
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
          _searchBook();
          break;
        case '8':
          _library.viewStatistics();
          break;
        case '9':
          print(' Exiting... Goodbye!');
          return;
        default:
          print(' Invalid choice. Please enter a number between 1 and 9.');
      }
      
      print('\nPress Enter to continue...');
      stdin.readLineSync();
    }
  }

  void _showMenu() {
    print('''
============================================================
WELCOME TO THE LIBRARY MANAGEMENT SYSTEM 
============================================================

------------------------------------------------------------
 MAIN MENU
------------------------------------------------------------
1.  View All Books
2.  View Available Books
3.  View Borrowed Books
4.  Add a New Book
5.  Borrow a Book
6.  Return a Book
7.  Search Books by Title
8.  View Library Statistics
9.  Exit
------------------------------------------------------------''');
  }

  void _addBook() {
    stdout.write('Enter Book Title: ');
    String? title = stdin.readLineSync();
    stdout.write('Enter Book Author: ');
    String? author = stdin.readLineSync();
    stdout.write('Enter Publication Year: ');
    String? yearStr = stdin.readLineSync();

    if (title != null && title.isNotEmpty && author != null && author.isNotEmpty && yearStr != null) {
      int? year = int.tryParse(yearStr);
      if (year != null) {
        _library.addBook(title, author, year);
      } else {
        print(' Invalid year format.');
      }
    } else {
      print(' All fields are required.');
    }
  }

  void _borrowBook() {
    stdout.write('Enter Book ID to borrow: ');
    String? id = stdin.readLineSync();
    if (id != null && id.isNotEmpty) {
      _library.borrowBook(id);
    }
  }

  void _returnBook() {
    stdout.write('Enter Book ID to return: ');
    String? id = stdin.readLineSync();
    if (id != null && id.isNotEmpty) {
      _library.returnBook(id);
    }
  }

  void _searchBook() {
    stdout.write('Enter title keyword to search: ');
    String? keyword = stdin.readLineSync();
    if (keyword != null && keyword.isNotEmpty) {
      _library.searchBooksByTitle(keyword);
    }
  }
}

void main() {
  LibraryApp app = LibraryApp();
  app.start();
}
