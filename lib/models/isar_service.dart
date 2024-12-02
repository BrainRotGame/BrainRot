// import 'package:isar/isar.dart';
// import 'package:brainrot/models/word.dart';
// import 'package:brainrot/models/category.dart';
// import 'package:brainrot/models/collection.dart';

// class IsarService {
//   final Isar _isar;

//   IsarService({required Isar isar}) : _isar = isar;

//   // Fetch all categories in a collection
//   Future<List<Category>> getAllCategories() async {
//     return await _isar.categorys.where().findAll();
//   }

//   // Fetch all words in a category
//   Future<List<Word>> getWordsForCategory(Id categoryId) async {
//     final category = await _isar.categorys.get(categoryId);
//     if (category != null) {
//       await category.words.load();
//       return category.words.toList();
//     }
//     return [];
//   }

//   // Add or update a category
//   Future<void> upsertCategory(Category category) async {
//     await _isar.writeTxn(() async {
//       await _isar.categorys.put(category);
//     });
//   }

//   // Add or update a word in a category
//   Future<void> upsertWord(Word word, Category category) async {
//     await _isar.writeTxn(() async {
//       category.words.add(word);
//       await _isar.words.put(word);
//       await _isar.categorys.put(category); // Save the link
//     });
//   }

//   // Remove a category and its words
//   Future<void> deleteCategory(Id categoryId) async {
//     await _isar.writeTxn(() async {
//       final category = await _isar.categorys.get(categoryId);
//       if (category != null) {
//         await category.words.load();
//         await _isar.words.deleteAll(category.words.map((w) => w.id).toList());
//         await _isar.categorys.delete(categoryId);
//       }
//     });
//   }

//   // Remove a word from a category
//   Future<void> removeWordFromCategory(Id wordId, Id categoryId) async {
//     await _isar.writeTxn(() async {
//       final category = await _isar.categorys.get(categoryId);
//       if (category != null) {
//         await category.words.load();
//         category.words.removeWhere((w) => w.id == wordId);
//         await _isar.words.delete(wordId);
//         await _isar.categorys.put(category); // Update the category links
//       }
//     });
//   }

//   // Check if a category exists
//   Future<bool> isCategoryExists(String categoryName) async {
//     final existingCategory = await _isar.categorys
//         .filter()
//         .categoryNameEqualTo(categoryName, caseSensitive: false)
//         .findFirst();
//     return existingCategory != null;
//   }

//   // Check if a word exists in a category
//   Future<bool> isWordExistsInCategory(Id categoryId, String wordText) async {
//     final category = await _isar.categorys.get(categoryId);
//     if (category != null) {
//       await category.words.load();
//       return category.words.any((word) => word.wordName.toLowerCase() == wordText.toLowerCase());
//     }
//     return false;
//   }
// }
