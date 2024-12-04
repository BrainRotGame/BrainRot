// import 'package:brainrot/models/collection.dart';
import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'category.g.dart';

//Object represents a Category collection
//Categories can be customized to have a name and users can add words associated to it
@collection
class Category extends ChangeNotifier {
  Id? id;
  final String categoryName;
  // final _category = IsarLinks<Word>();
  IsarLinks<Word> words = IsarLinks<Word>();
  // final Isar _isar;

  Category({required this.categoryName});

  //Method will get all words within the category as a list
  //@param: takes in an Isar to extract the words
  List<Word> getWords(Isar isar) {
    words.loadSync(); // Ensure links are loaded
    return words.toList();
  }

  //Method will add/update a word within the category
  //If the word already exists within the category, it'll be updated, otherwise the word will be added into the category
  //@param: takes in Isar to update, and the word that's being upserted into the category
  void upsertWord({required Isar isar, required Word word}) {
    isar.writeTxnSync(() {
      isar.words.putSync(word); // Save the word synchronously
      words.add(word);          // Link word to category synchronously
      isar.categorys.putSync(this); // Save updated category synchronously
    });

    notifyListeners();
  }

  //Method will remove a word within the category
  //@param: Takes in a Isar to remove from, and a word that's being removed
  void removeWord({required Isar isar, required Word word}) {
    isar.writeTxnSync(() {
      isar.words.deleteSync(word.id!);
      words.remove(word);
      isar.categorys.putSync(this); 
    });

  notifyListeners();
}

}
