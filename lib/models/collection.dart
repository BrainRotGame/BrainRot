import 'package:brainrot/models/category.dart';
import 'package:isar/isar.dart';

class CategoryCollection {
  final List<Category> _collection;
  final Isar _isar;

  // Constructor
  // Collection() : _collection = [];
  CategoryCollection({required Isar isar}) : _collection = isar.categorys.where().findAllSync(), _isar = isar;

  // Getter method for collection
  List<Category> get collection => List.from(_collection);

  // Add or update category
  void upsertCategory(Category category) async {
    // Check if the category already exists (case-insensitive)
    final existingIndex = _collection.indexWhere(
      (existingCategory) =>
          existingCategory.categoryName.toLowerCase() ==
          category.categoryName.toLowerCase(),
    );

    if (existingIndex != -1) {
      // notify user the word already exist
      // print('Category "${category.categoryName}" already exists.');
    } else {
      // Add new category
      _collection.add(category);
      //print('Added category "${category.categoryName}".');
    }
    await _isar.writeTxn(() async {
      await _isar.categorys.put(category);
    });
    
  }

  // Helper to check if a category exists in the collection
  bool isCategoryExists(String categoryName) {
    return _collection.any(
      (category) =>
          category.categoryName.toLowerCase() == categoryName.toLowerCase(),
    );
  }

  // method that allows for access to all categories in the collection data
  List<Category> allCategories() {
    return List.from(_collection);
  }
}
