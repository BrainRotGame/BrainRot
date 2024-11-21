import 'package:brainrot/models/category.dart';

class Collection {
  final List<Category> _collection;

  // Constructor
  Collection() : _collection = [];

  // Getter method for collection
  List<Category> get collection => List.from(_collection);

  // Add or update category
  void upsertCategory(Category category) {
    // Check if the category already exists (case-insensitive)
    final existingIndex = _collection.indexWhere(
      (existingCategory) =>
          existingCategory.categoryName.toLowerCase() ==
          category.categoryName.toLowerCase(),
    );

    if (existingIndex != -1) {
      // notify user the word already exist
      //print('Category "${category.categoryName}" already exists.');
    } else {
      // Add new category
      _collection.add(category);
      //print('Added category "${category.categoryName}".');
    }
  }

  // Helper to check if a category exists in the collection
  bool isCategoryExists(String categoryName) {
    return _collection.any(
      (category) =>
          category.categoryName.toLowerCase() == categoryName.toLowerCase(),
    );
  }
}
