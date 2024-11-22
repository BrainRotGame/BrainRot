import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';

//GameStateProvider will keep track of the game state when a game's being played
//Provider will maintain score and time of the current game
class GameStateProvider extends ChangeNotifier{

  int time;
  int correct;
  int skipped;
  List<Word> words;

  GameStateProvider({required this.time, required this.words}) : correct = 0, skipped = 0;

  void incrementCorrect() {
    correct++;
    // words.removeLast();
    notifyListeners();
  }

  void incrementSkip() {
    skipped++;
    // words.removeLast();
    notifyListeners();
  }

  void refreshGameState() {
    correct = 0;
    skipped = 0;
    notifyListeners();
  }
}