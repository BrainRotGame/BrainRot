import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';

//GameStateProvider will keep track of the game state when a game's being played
//Provider will maintain score and time of the current game
class GameStateProvider extends ChangeNotifier{

  int time;
  int correct;
  int skipped;
  List<Word> words;
  List<Word> guessedWords;
  bool finished;

  GameStateProvider({required this.time, required this.words}) : correct = 0, skipped = 0, guessedWords = [], finished = false;

  //Method will increment the correct counter and add the current word to the list of correctly guessed words
  void incrementCorrect() {
    correct++;
    guessedWords.add(words[0]);
    words.removeAt(0);
    if(words.isEmpty) {
      finished = true;
    }
    notifyListeners();
  }

  //Method will increment the skip counter
  void incrementSkip() {
    skipped++;
    words.removeAt(0);
    if(words.isEmpty) {
      finished = true;
    }
    notifyListeners();
  }

  //Method will refresh the game state, setting all counters to 0 and setting the game state to being played
  void refreshGameState() {
    correct = 0;
    skipped = 0;
    finished = false;
    notifyListeners();
  }
}