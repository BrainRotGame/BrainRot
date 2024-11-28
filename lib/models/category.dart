import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';

class Category extends ChangeNotifier {
  final String categoryName;
  final List<Word> _category;

  // Constructor
  Category({required this.categoryName, List<Word>? words})
      : _category = words ?? [];

  // Getter method for the list of words
  List<Word> get category => List.unmodifiable(_category);

  // Add or update a word in the category
  void upsertCategory(Word word) {

    // Find the index of the word with the same id
    final index = _category.indexWhere((w) => w.id == word.id);

    if (index != -1) {
      // Update the existing word
      _category[index] = word;
    } else {
      // Add a new word
      _category.add(word);
    }
    notifyListeners();
  }

  // Remove a word by its id
  void removeWordById(int id) {
    _category.removeWhere((w) => w.id == id); // Remove the word with the given ID
    notifyListeners(); // Notify listeners that the list has changed
  }


  // Helper method to check if a word with a specific id exists
  bool isWordExistsById(int id) {
    return _category.any((word) => word.id == id);
  }

  // Helper method to clone the category
  Category clone() {
    return Category(
      categoryName: categoryName,
      words: List.from(_category),
    );
  }
}
