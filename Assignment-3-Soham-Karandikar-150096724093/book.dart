// Abstract class

abstract class LibraryItem {
  void borrowItem();
  void returnItem();
  void displayInfo();
}



class Book extends LibraryItem {
  // Private Fields
  int _id;
  String _title;
  String _author;
  int _year; 
  bool _isAvailable;

  // Constructor
  Book(
    this._id,
    this._title,
    this._author,
    this._year,
    {bool isAvailable=true,}
  ) : _isAvailable = isAvailable;

  // Getters and Setters
  int get id => _id;
  set id(int val){
    _id = val;
  }

  String get title => _title;
  set title(String val){
    _title = val;
  }

  String get author => _author;
  set author(String val){
    _author = val;
  }

  int get year => _year;
  set year(int val){
    _year = val;
  }

  bool get isAvailable => _isAvailable;
  set isAvailable(bool val){
    _isAvailable = val;
  }

  // Overridden methods
  void borrowItem(){
    if(_isAvailable){
      _isAvailable = false;
      print('"$_title" has been borrowed successfully.');
    }else{
      print("$_title is already borrowed");
    }
  }

  void returnItem() {
    if (!_isAvailable) {
      _isAvailable = true;
      print('"$_title" has been returned successfully.');
    } else {
      print('"$_title" is already available.');
    }
  }

  void displayInfo() {
    print(
      'ID: $_id | '
      'Title: $_title | '
      'Author: $_author | '
      'Year: $_year | '
      'Status: ${_isAvailable ? "Available" : "Borrowed"}',
    );
  }

}