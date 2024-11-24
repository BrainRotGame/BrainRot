import 'package:brainrot/utils/mocker.dart';
import 'package:flutter/material.dart';
import 'package:brainrot/models/category.dart';

class CollectionProvider with ChangeNotifier {
  final List<Category> _categories = gameMocker().collection;

  List<Category> get categories => _categories;

  void addCategory(String categoryName) {
    final newCategory = Category(categoryName: categoryName, words: []);
    _categories.add(newCategory);
    notifyListeners();
  }
}