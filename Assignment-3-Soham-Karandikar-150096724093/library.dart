import 'book.dart';

class Library {
  // Library manages a List<Book>
  final List<Book> _books = [];

  // Add a new book
  void addBook(Book book) {
    // Prevent duplicate IDs
    if (_books.any((existingBook) => existingBook.id == book.id)) {
      print('A book with ID ${book.id} already exists.');
      return;
    }

    _books.add(book);
    print('Book added successfully.');
  }

  // Search books by title.
  // Partial and case-insensitive matches are allowed.
  void searchBooks(String query) {
    if (query.trim().isEmpty) {
      print('Search query cannot be empty.');
      return;
    }

    String searchQuery = query.trim().toLowerCase();

    List<Book> results = _books.where((book) {
      return book.title.toLowerCase().contains(searchQuery);
    }).toList();

    if (results.isEmpty) {
      print('No books found matching "$query".');
      return;
    }

    print('\nSearch Results:');
    print('----------------');
    for (Book book in results) {
      book.displayInfo();
    }
  }

  // Borrow a book using its ID
  void borrowBook(int id) {
    Book? book = _findBookById(id);

    if (book == null) {
      print('Book with ID $id does not exist.');
      return;
    }

    book.borrowItem();
  }

  // Return a book using its ID
  void returnBook(int id) {
    Book? book = _findBookById(id);

    if (book == null) {
      print('Book with ID $id does not exist.');
      return;
    }

    book.returnItem();
  }

  // Display all books
  void displayAllBooks() {
    if (_books.isEmpty) {
      print('The library is empty.');
      return;
    }

    print('\nAll Books');
    print('---------');

    for (Book book in _books) {
      book.displayInfo();
    }
  }

  // Display available books
  void displayAvailableBooks() {
    List<Book> availableBooks =
        _books.where((book) => book.isAvailable).toList();

    if (availableBooks.isEmpty) {
      print('No books are currently available.');
      return;
    }

    print('\nAvailable Books');
    print('---------------');

    for (Book book in availableBooks) {
      book.displayInfo();
    }
  }

  // Display borrowed books
  void displayBorrowedBooks() {
    List<Book> borrowedBooks =
        _books.where((book) => !book.isAvailable).toList();

    if (borrowedBooks.isEmpty) {
      print('No books are currently borrowed.');
      return;
    }

    print('\nBorrowed Books');
    print('--------------');

    for (Book book in borrowedBooks) {
      book.displayInfo();
    }
  }

  // Display library statistics
  void displayStatistics() {
    int totalBooks = _books.length;

    int availableBooks =
        _books.where((book) => book.isAvailable).length;

    int borrowedBooks = totalBooks - availableBooks;

    double availabilityPercentage = totalBooks == 0
        ? 0
        : (availableBooks / totalBooks) * 100;

    print('\nLibrary Statistics');
    print('------------------');
    print('Total Books: $totalBooks');
    print('Available Books: $availableBooks');
    print('Borrowed Books: $borrowedBooks');
    print(
      'Availability: ${availabilityPercentage.toStringAsFixed(2)}%',
    );
  }

  // Private helper method to find a book by ID
  Book? _findBookById(int id) {
    for (Book book in _books) {
      if (book.id == id) {
        return book;
      }
    }

    return null;
  }
}