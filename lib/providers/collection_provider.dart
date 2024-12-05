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

  CollectionProvider({required Isar isar}) 
  {
    _collection = CategoryCollection(isar: isar);
    if(_collection.collection.isEmpty) {
      gameMocker(isar: isar, gameCollection: _collection);
    }
    // if(isar.categorys.countSync() == 0) {
    //   _collection = gameMocker(isar: isar);
    // }
    // else {
    //   _collection = CategoryCollection(isar: isar);
    // }
  }

  // void addCategory(String categoryName) {
  //   final newCategory = Category(categoryName: categoryName, words: []);
  //   _categories.add(newCategory);
  //   notifyListeners();
  // }

  //Method will add a new category to the collection
  //@param takes in a category to add
  void addCategory(String category) {
    final newCategory = Category(categoryName: category);
    _collection.upsertCategory(newCategory);
    notifyListeners();
  }
}