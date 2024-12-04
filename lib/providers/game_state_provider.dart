import 'package:brainrot/models/category.dart';
// import 'package:brainrot/models/collection.dart';
import 'package:brainrot/models/word.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

//GameStateProvider will keep track of the game state when a game's being played
//Provider will maintain score and time of the current game
class GameStateProvider extends ChangeNotifier{

  int time;
  int correct;
  int skipped;
  List<Word> words;
  List<Word> guessedWords;
  bool finished;
  bool hint;

  GameStateProvider()
  :
  time = 0,
  correct = 0,
  skipped = 0,
  words = [],
  guessedWords = [],
  finished = false,
  hint = false;

  // updated the time with a new value of time
  // Parameters:
    // newTime: new time set for the game
  void setTime(int newTime) {
    time = newTime;
  }

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
  void refreshGameState({required Category category, required int newTime, required Isar isar, required bool notify}) {
    correct = 0;
    skipped = 0;
    // clears list of words
    guessedWords = [];
    finished = false;

    final List<Word> temp = List.from(category.getWords(isar));
    temp.shuffle();
    words = temp;

    time = newTime;
    if(notify) {
      notifyListeners();
    }
    
  }

  //Method will switch to a new term
  void newTerm() {
    if (words.isNotEmpty) {
      words.removeAt(0);
    }
    // if the list of words are empty we want to ensure that the words are shuffled
    if(words.isEmpty) {
      finished = true;
    }
    notifyListeners();
  }

  //Method will decrement timer
  //If the timer is decremented down to 0, it'll complete the game
  void decrementTimer() {
    time--;
    if(time == 0) {
      finished = true;
    }
    notifyListeners();
  }

  // method created to update the UI and display a hint to the user
  // if asked
  void toggleHint() {
    hint = !hint;
    notifyListeners();
  }

}