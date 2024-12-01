import 'package:isar/isar.dart';
import 'package:brainrot/models/collection.dart';
import 'package:brainrot/utils/mocker.dart';
import 'package:brainrot/models/category.dart';
import 'package:flutter/material.dart';

class CollectionProvider extends ChangeNotifier {
  // final List<Category> _categories = gameMocker().collection;
  final CategoryCollection _collection;

  List<Category> get categories => _collection.collection;

  CollectionProvider({required Isar isar}) : _collection = CategoryCollection(isar: isar);

  // void addCategory(String categoryName) {
  //   final newCategory = Category(categoryName: categoryName, words: []);
  //   _categories.add(newCategory);
  //   notifyListeners();
  // }

  void addCategory(String category) {
    final newCategory = Category(categoryName: category);
    _collection.upsertCategory(newCategory);
    notifyListeners();
  }
}