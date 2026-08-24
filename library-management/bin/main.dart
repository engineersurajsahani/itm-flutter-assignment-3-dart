import '../lib/services/library.dart';
import '../lib/ app/library_app.dart';
import '../lib/book.dart';

void main() {
  // Create the library
  final library = Library();

  // Add some sample books
  library.addBook(
    Book(
      id: 1,
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      year: 1988,
    ),
  );

  library.addBook(
    Book(
      id: 2,
      title: '1984',
      author: 'George Orwell',
      year: 1949,
    ),
  );

  library.addBook(
    Book(
      id: 3,
      title: 'Harry Potter',
      author: 'J.K. Rowling',
      year: 1997,
    ),
  );

  library.addBook(
    Book(
      id: 4,
      title: 'Clean Code',
      author: 'Robert C. Martin',
      year: 2008,
    ),
  );

  // Create the application
  final app = LibraryApp(library);

  // Start the application
  app.start();
}