import '../book.dart';

class Library {
  // Stores all the books in the library
  final List<Book> _books = [];

  // 1. Add a new book
  void addBook(Book book) {
    _books.add(book);
    print('Book "${book.title}" added successfully.');
  }

  // 2. View all books
  void displayAllBooks() {
    if (_books.isEmpty) {
      print('No books available in the library.');
      return;
    }

    print('\n===== ALL BOOKS =====');

    for (var book in _books) {
      book.displayInfo();
      print('---------------------');
    }
  }

  // 3. View available books
  void displayAvailableBooks() {
    bool found = false;

    print('\n===== AVAILABLE BOOKS =====');

    for (var book in _books) {
      if (book.availability) {
        book.displayInfo();
        print('---------------------');
        found = true;
      }
    }

    if (!found) {
      print('No available books.');
    }
  }

  // 4. View borrowed books
  void displayBorrowedBooks() {
    bool found = false;

    print('\n===== BORROWED BOOKS =====');

    for (var book in _books) {
      if (!book.availability) {
        book.displayInfo();
        print('---------------------');
        found = true;
      }
    }

    if (!found) {
      print('No borrowed books.');
    }
  }

  // 5. Search book by title
  void searchBook(String query) {
    bool found = false;

    print('\n===== SEARCH RESULTS =====');

    for (var book in _books) {
      if (book.title.toLowerCase().contains(query.toLowerCase())) {
        book.displayInfo();
        print('---------------------');
        found = true;
      }
    }

    if (!found) {
      print('No books found matching "$query".');
    }
  }

  // 6. Borrow a book using its ID
  void borrowBook(int id) {
    for (var book in _books) {
      if (book.id == id) {
        book.borrowItem();
        return;
      }
    }

    print('Book with ID $id not found.');
  }

  // 7. Return a book using its ID
  void returnBook(int id) {
    for (var book in _books) {
      if (book.id == id) {
        book.returnItem();
        return;
      }
    }

    print('Book with ID $id not found.');
  }

  // 8. Show library statistics
  void showStatistics() {
    int totalBooks = _books.length;
    int availableBooks = 0;

    for (var book in _books) {
      if (book.availability) {
        availableBooks++;
      }
    }

    int borrowedBooks = totalBooks - availableBooks;

    double availabilityPercentage = totalBooks == 0
        ? 0
        : (availableBooks / totalBooks) * 100;

    print('\n===== LIBRARY STATISTICS =====');
    print('Total Books       : $totalBooks');
    print('Available Books   : $availableBooks');
    print('Borrowed Books    : $borrowedBooks');
    print(
      'Availability      : ${availabilityPercentage.toStringAsFixed(2)}%',
    );
  }
}