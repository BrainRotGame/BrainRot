// a list of words in the same category

import 'package:brainrot/models/word.dart';

class Category {

  final String categoryName;
  final List<Word> _category;

  // constructor
  Category({required this.categoryName, List<Word>? words})
      : _category = words ?? [];

  // Getter method for list of category
  List<Word> get category => List.from(_category);

  // add or update category
  void upsertCategory(Word word) {
    if (isWordExists(word.wordName.toLowerCase())) {
      // notify user the word already exist
    } else {
      _category.add(word);
    }
  }

  // helper to check is the word exist in our list
  bool isWordExists(String wordName) {
    return _category.any((word) => word.wordName.toLowerCase() == wordName.toLowerCase());
  }
}

