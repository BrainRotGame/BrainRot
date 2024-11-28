import 'package:flutter/material.dart';
import 'package:brainrot/models/word.dart';

class WordBankProvider extends ChangeNotifier {
  final List<Word> _words = [];

  List<Word> get words => List.unmodifiable(_words);

  void addWord(Word word) {
    _words.add(word);
    notifyListeners();
  }

  void updateWordById(int id, Word updatedWord) {
    final index = _words.indexWhere((w) => w.id == id);
    if (index != -1) {
      _words[index] = updatedWord;
      notifyListeners();
    } else {
      print('Word with id $id not found in WordBankProvider');
    }
  }

  void removeWordById(int id) {
    _words.removeWhere((w) => w.id == id);
    notifyListeners();
  }
}
