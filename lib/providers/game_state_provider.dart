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
  bool clearDrawing;

  GameStateProvider({required this.time, required this.words}) : correct = 0, skipped = 0, guessedWords = [], finished = false, clearDrawing = false;

  //Method will increment the correct counter and add the current word to the list of correctly guessed words
  void incrementCorrect() {
    if (!finished) {
      correct++;
      guessedWords.add(words[0]);
      newTerm();
      notifyListeners();
    }
  }

  //Method will increment the skip counter
  void incrementSkip() {
    if (!finished) {
      skipped++;
      newTerm();
      notifyListeners();
    }
  }

  //Method will refresh the game state, setting all counters to 0 and setting the game state to being played
  void refreshGameState(List<Word>? newWords) {
    correct = 0;
    skipped = 0;
    // clears list of words
    guessedWords = [];
    finished = false;
    //allows for game to reset with new set of words
    if (newWords != null) {
      words = newWords;
    }
    notifyListeners();
  }

  void newTerm() {
    words.removeAt(0);
    if(words.isEmpty) {
      finished = true;
    }
    clearDrawing = true;
    notifyListeners();
    clearDrawing = false;
  }
}