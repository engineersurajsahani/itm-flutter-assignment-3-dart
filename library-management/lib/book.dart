import 'library_item.dart';
class Book extends LibraryItem {
  int id;
  String title;
  String author;
  int year;
  bool availability;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.year,
    this.availability = true,

  });
  @override
  void borrowItem(){
    if (this.availability){
      this.availability=false;
      print("${title}  has been borrowed");
    }
    else{
      print("${title} is already borrowed ");
    }


  }
  @override
  void displayInfo(){
    print("ID ${this.id}");
    print("Title ${this.title}");
    print("Author ${this.author}");
    print("Year ${this.year}");
    print("Available ${this.availability}");

  }
  @override
  void returnItem(){
    if(!this.availability){
      this.availability=true;
      print("${this.title} has been returned");
    }
    else{
      print("${this.title} is already available");
    }


  }
}
