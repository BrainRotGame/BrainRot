// word name
// description
// hint(optional)

// import 'package:brainrot/models/category.dart';
import 'package:isar/isar.dart';
part 'word.g.dart';

//Object represents a word
//Words must have a name, description, and an optional hold
@collection
class Word {
  // final int id;
  Id? id;
  final String wordName;
  final String description;
  final String? hint;

  // constructor
  Word({
    this.id,
    required this.wordName,
    required this.description,
    this.hint,
  });

  //Constructor will create a new word from a preexisting word, but with a new name, description, and hint
  //@param: takes in a preexisting word, an updated name, description, and hint
  Word.withUpdatedData({required Word original, String? newWordName, String? newDescription, String? newHint, })
   : id = original.id,
    wordName = newWordName ?? original.wordName,
    description = newDescription ?? original.description,
    hint = newHint ?? original.hint;

  @override
  //Returns a String representation of the word
  String toString() {
    return 'Word(wordName: $wordName, description: $description, hint: $hint)';
  }
}