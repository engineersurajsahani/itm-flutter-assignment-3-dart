import 'dart:io';
abstract class LibraryItem {
  int get id;
  String get title;
  String get author;
  int get year;

  void displayInfo();
}

class Book extends LibraryItem {
  int _id;
  String _title;
  String _author;
  int _year;
  bool _isAvailable;

  Book(
    this._id,
    this._title,
    this._author,
    this._year, {
    bool isAvailable = true,
  }) : _isAvailable = isAvailable;

  @override
  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String get title => _title;

  set title(String value) {
    _title = value;
  }

  @override
  String get author => _author;

  set author(String value) {
    _author = value;
  }

  @override
  int get year => _year;

  set year(int value) {
    _year = value;
  }

  bool get isAvailable => _isAvailable;

  set isAvailable(bool value) {
    _isAvailable = value;
  }

  void borrowBook() {
    if (_isAvailable) {
      _isAvailable = false;
      print('Book borrowed successfully.');
    } else {
      print('Book is already borrowed.');
    }
  }

  void returnBook() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('Book returned successfully.');
    } else {
      print('Book is already available.');
    }
  }

  @override
  void displayInfo() {
    print(
      'ID: $_id | Title: $_title | Author: $_author | '
      'Year: $_year | Status: ${_isAvailable ? "Available" : "Borrowed"}',
    );
  }
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
    print('Book added successfully.');
  }

  void displayAllBooks() {
    if (_books.isEmpty) {
      print('No books available in the library.');
      return;
    }

    print('\n===== ALL BOOKS =====');

    for (Book book in _books) {
      book.displayInfo();
    }
  }

  void displayAvailableBooks() {
    print('\n===== AVAILABLE BOOKS =====');

    bool found = false;

    for (Book book in _books) {
      if (book.isAvailable) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No available books.');
    }
  }

  void displayBorrowedBooks() {
    print('\n===== BORROWED BOOKS =====');

    bool found = false;

    for (Book book in _books) {
      if (!book.isAvailable) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No borrowed books.');
    }
  }

  Book? findBookById(int id) {
    for (Book book in _books) {
      if (book.id == id) {
        return book;
      }
    }

    return null;
  }

  void borrowBook(int id) {
    Book? book = findBookById(id);

    if (book == null) {
      print('Book with ID $id not found.');
      return;
    }

    book.borrowBook();
  }

  void returnBook(int id) {
    Book? book = findBookById(id);

    if (book == null) {
      print('Book with ID $id not found.');
      return;
    }

    book.returnBook();
  }

  void searchByTitle(String searchTitle) {
    print('\n===== SEARCH RESULTS =====');

    bool found = false;

    for (Book book in _books) {
      if (book.title.toLowerCase().contains(searchTitle.toLowerCase())) {
        book.displayInfo();
        found = true;
      }
    }

    if (!found) {
      print('No books found with title "$searchTitle".');
    }
  }

  void showStatistics() {
    int totalBooks = _books.length;
    int availableBooks = 0;
    int borrowedBooks = 0;

    for (Book book in _books) {
      if (book.isAvailable) {
        availableBooks++;
      } else {
        borrowedBooks++;
      }
    }

    print('\n===== LIBRARY STATISTICS =====');
    print('Total Books     : $totalBooks');
    print('Available Books : $availableBooks');
    print('Borrowed Books  : $borrowedBooks');
  }
}

class LibraryApp {
  final Library library;

  LibraryApp(this.library);

  void start() {
    bool running = true;

    while (running) {
      print('\n');
      print('========== LIBRARY MANAGEMENT SYSTEM ==========');
      print('1. View All Books');
      print('2. View Available Books');
      print('3. View Borrowed Books');
      print('4. Add New Book');
      print('5. Borrow Book');
      print('6. Return Book');
      print('7. Search Book by Title');
      print('8. Library Statistics');
      print('9. Exit');
      print('================================================');

      stdout.write('Enter your choice: ');

      String? input = stdin.readLineSync();

      int? choice = int.tryParse(input ?? '');

      if (choice == null) {
        print('Invalid input. Please enter a number.');
        continue;
      }

      switch (choice) {
        case 1:
          library.displayAllBooks();
          break;

        case 2:
          library.displayAvailableBooks();
          break;

        case 3:
          library.displayBorrowedBooks();
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
          library.showStatistics();
          break;

        case 9:
          print('Thank you for using the Library Management System!');
          running = false;
          break;

        default:
          print('Invalid choice. Please select 1-9.');
      }
    }
  }

  void addNewBook() {
    print('\n===== ADD NEW BOOK =====');

    stdout.write('Enter Book ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');

    if (id == null) {
      print('Invalid ID.');
      return;
    }

    if (library.findBookById(id) != null) {
      print('A book with this ID already exists.');
      return;
    }

    stdout.write('Enter Book Title: ');
    String title = stdin.readLineSync() ?? '';

    stdout.write('Enter Author Name: ');
    String author = stdin.readLineSync() ?? '';

    stdout.write('Enter Publication Year: ');
    int? year = int.tryParse(stdin.readLineSync() ?? '');

    if (year == null) {
      print('Invalid year.');
      return;
    }

    Book book = Book(id, title, author, year);

    library.addBook(book);
  }

  void borrowBook() {
    print('\n===== BORROW BOOK =====');

    stdout.write('Enter Book ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');

    if (id == null) {
      print('Invalid ID.');
      return;
    }

    library.borrowBook(id);
  }

  void returnBook() {
    print('\n===== RETURN BOOK =====');

    stdout.write('Enter Book ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');

    if (id == null) {
      print('Invalid ID.');
      return;
    }

    library.returnBook(id);
  }

  void searchBook() {
    print('\n===== SEARCH BOOK =====');

    stdout.write('Enter title to search: ');
    String title = stdin.readLineSync() ?? '';

    if (title.trim().isEmpty) {
      print('Search title cannot be empty.');
      return;
    }

    library.searchByTitle(title);
  }
}

void main() {
  Library library = Library();

  library.addBook(
  Book(1, 'Project Hail Mary', 'Andy Weir', 2021),
);

library.addBook(
  Book(2, 'The Silent Patient', 'Alex Michaelides', 2019),
);

library.addBook(
  Book(3, 'Ikigai', 'Hector Garcia', 2016),
);

library.addBook(
  Book(4, 'Educated', 'Tara Westover', 2018),
);

library.addBook(
  Book(5, 'The Midnight Library', 'Matt Haig', 2020),
);

  LibraryApp app = LibraryApp(library);

  app.start();
}