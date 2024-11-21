// a list of words in the same category

import 'package:brainrot/models/word.dart';

class Category {

  final List<Word> _category;

  // constructor
  Category() : _category = [];


  // Getter method for category
  List<Word> get category => List.from(_category);

}

