import 'package:brainrot/utils/mocker.dart';
import 'package:isar/isar.dart';
import 'package:brainrot/models/collection.dart';
// import 'package:brainrot/utils/mocker.dart';
import 'package:brainrot/models/category.dart';
import 'package:flutter/material.dart';

class CollectionProvider extends ChangeNotifier {
  // final List<Category> _categories = gameMocker().collection;
  late final CategoryCollection _collection;

  List<Category> get categories => _collection.collection;

  CollectionProvider({required Isar isar}) {
    //If collection is empty, then it'll load mock data into it (so if a user loads the app for the very first time, they're presented with some starter categories as opposed to a blank screen)
    _collection = CategoryCollection(isar: isar);
    if(_collection.collection.isEmpty) {
      gameMocker(isar: isar, gameCollection: _collection);
    }
  }


  //Method will add a new category to the collection
  //@param takes in a category to add
  void addCategory(String category) {
    final newCategory = Category(categoryName: category);
    _collection.upsertCategory(newCategory);
    notifyListeners();
  }
}