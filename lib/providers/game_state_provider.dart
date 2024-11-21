import 'package:flutter/material.dart';

//GameStateProvider will keep track of the game state when a game's being played
//Provider will maintain score and time of the current game
class GameStateProvider extends ChangeNotifier{
  int time;
  int correct;
  int skipped;

  GameStateProvider({required this.time}) : correct = 0, skipped = 0;

  void incrementCorrect() {
    correct++;
    notifyListeners();
  }

  void incrementSkip() {
    skipped++;
    notifyListeners();
  }

  void refreshGameState() {
    correct = 0;
    skipped = 0;
    notifyListeners();
  }
}