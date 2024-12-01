import 'package:brainrot/models/collection.dart';
import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category extends ChangeNotifier {
  Id? id;
  final String categoryName;
  final _category;
  // final Isar _isar;

  // Constructor
  // Category({required this.categoryName, List<Word>? words})
  //     : _category = words ?? [];
  Category({required this.categoryName}) 
      : _category = IsarLinks<Word>();

  //Constructor creates a Category from a given name, isar, and list of entries
  //@param: takes in a name, isar, and list of entries
  Category.recreate({required this.categoryName, required List<Word> category}) :
  // _entries = List.from(entries),
  _category = category;
  // _isar = isar;

  // Getter method for the list of words
  @ignore
  List<Word> get category => List.unmodifiable(_category);

  // Add or update a word in the category
  void upsertCategory(Word word) async {

    // Find the index of the word with the same id
    final index = _category.indexWhere((w) => w.id == word.id);

    if (index != -1) {
      // Update the existing word
      _category[index] = word;
    } else {
      // Add a new word
      _category.add(word);
    }
    // notifyListeners();
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
    // return Category(
    //   categoryName: categoryName,
    //   words: List.from(_category),
    // );
    return Category.recreate(categoryName: categoryName, category: _category);
  }
}
