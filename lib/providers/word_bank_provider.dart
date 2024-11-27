import 'package:flutter/material.dart';
import 'package:brainrot/models/word.dart';

class WordBankProvider extends ChangeNotifier {
  final List<Word> _words = [];

  List<Word> get words => List.unmodifiable(_words);

  void addWord(Word word) {
    _words.add(word);
    notifyListeners();
  }

  void updateWord(int index, Word updateWord) {
    if (index >= 0 && index < _words.length) {
      _words[index] = updateWord;
      notifyListeners();
    }
  }
}