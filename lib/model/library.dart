import 'package:bookend/model/book.dart';

class Library {
  String name;
  List<Book> books = List<Book>.empty();

  Library({required this.name, books}) {
    this.books = books ?? [];
  }
}
