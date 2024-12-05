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
  void upsertWord({required Isar isar, required Word word, required bool notify}) {
    isar.writeTxnSync(() {
      //Synchronously adds the word into the word collection within Isar
      isar.words.putSync(word); 
      words.add(word);          
      //Updates the category so that the category reflects the change of the word being put in
      isar.categorys.putSync(this); 
    });

    if(notify) {
      notifyListeners();
    }
    
  }

  //Method will remove a word within the category
  //@param: Takes in a Isar to remove from, and a word that's being removed
  void removeWord({required Isar isar, required Word word}) {
    isar.writeTxnSync(() {
      //synchronously deletes the word from the word collection within Isar
      isar.words.deleteSync(word.id!);
      words.remove(word);
      //Updates the category so that the category reflects the change of the word being deleted
      isar.categorys.putSync(this); 
    });

  notifyListeners();
}

}
