import 'dart:async';

import 'package:brainrot/models/category.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:io';

//Class created to display the GameView widget
//Gameview will allow users to play a game with a particular category
class GameView extends StatefulWidget {
  // category of words users will use in order to guess in the game
  final Isar isar;
  final Category category;
  // time defined to display a countdown while the user is playing the game
  final int time;


  const GameView({super.key, required this.isar, required this.time, required this.category});

  @override
  // creating a state for the widget of GameView
  State<GameView> createState() => _GameViewState();
}

// Class created for the UI of the gameview in order to display
// updates containing the timer and sensor view
class _GameViewState extends State<GameView> {
  // tracks time to ensure user is displayed a countdown timer
  late Timer _gameTimer;


  @override
  // method created to initialize the sensor view and gameview when the widget
  // is initially created
  void initState() {
    super.initState();
    _sensorView();
    
    _restart(notify: false);
    
  }

  @override
  // created to ensure the widget is cleaned up/disposed and removed from the
  // widget tree and cancels the timer for the game
  void dispose() {
    _gameTimer.cancel();
    super.dispose();
  }

// @override
// // ensuring context and widget tree are available
// // in which they can be accessed
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   // called once we know that the context has been initialized
//   _sensorView();  // Start listening after context is available
// }

  // Method created in order to determine the detection of the
  // change in orientation the user makes with their device
  void _sensorView() {
    if (Platform.isAndroid || Platform.isIOS) {
      bool deviceFlipsUp = false; // user sets the device to face up
      bool deviceFlipsDown = false; // user sets the device to face down
      accelerometerEvents.listen((AccelerometerEvent e) {
        // ignore: use_build_context_synchronously
        final gameStateProvider = Provider.of<GameStateProvider>(context, listen:false);
        // z -> axis representing front to back, x(left to right), y(top to bottom)
        // 9.5 -> threshold set to detect movement with device (facing upward if +9.5, and downward -9.5)
        // motion of sensor moving up, increment correct
        // the devices have yet to be flagged in order to prevent any repetition
        // occuring
        if (e.z > 9.5 && !deviceFlipsUp) {
          deviceFlipsUp = true;
          deviceFlipsDown = false;
          gameStateProvider.incrementCorrect();
        } else if (e.z < -9.5 && !deviceFlipsDown) { // motion of sensor moving down, increment skip
          deviceFlipsDown = true;
          deviceFlipsUp = false;
          gameStateProvider.incrementSkip();
        }
      });
    }
  }

  @override
  // Builds the widget's UI in order to display the main view of the game state
  // Parameters:
    // context: passed in to provide access to other widgets
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (context, gameStateProvider, child) {
        // Call the game finished dialog if the game is complete
        if (gameStateProvider.finished) {
          _gameTimer.cancel();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _gameFinished(context, gameStateProvider);
          });
        }

      // Render UI based on whether the game is finished
      if (!gameStateProvider.finished) {
        return Scaffold(
          backgroundColor: Colors.lightBlue[100],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => gameStateProvider.incrementCorrect(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.arrow_upward_rounded, color: Color.fromARGB(255, 52, 112, 54),),
                    Text('Flip phone up or tap for guessing correctly', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 52, 112, 54))),
                    Icon(Icons.arrow_upward_rounded, color: Color.fromARGB(255, 52, 112, 54),),
                  ],)
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text('Time Remaining: ${(gameStateProvider.time / 60).floor()}:${(gameStateProvider.time % 60).toString().padLeft(2,'0')}', style: const TextStyle(fontSize: 18),),
                            Text('Correct Guesses: ${gameStateProvider.correct}',  style: const TextStyle(fontSize: 18)),
                            Text('Skipped: ${gameStateProvider.skipped}',  style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(width:650, child: Text(gameStateProvider.words[0].wordName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,)),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () => _navigateToDrawing(context),
                        child: const Text("Navigate to drawing", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                        onPressed: () {Navigator.pop(context); }, 
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 255, 255, 255)), foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 36, 36, 36))),
                        icon: const Icon(Icons.clear, color: Color.fromARGB(255, 192, 56, 56),), iconSize: 30,)
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => gameStateProvider.incrementSkip(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.arrow_downward_rounded, color: Color.fromARGB(255, 192, 56, 56),),
                        Text('Flip phone down or tap for skipping', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 192, 56, 56)),),
                        Icon(Icons.arrow_downward_rounded, color: Color.fromARGB(255, 192, 56, 56)),
                      ],)
                    ),
                  ]
                ),
              ],
            ),
          ),
        );
      }
      // else {
      //   return const Scaffold(
      //     body: Padding(
      //       padding: EdgeInsets.all(20.0),
      //       child: Text('FINISHED'),
      //     ),
      //   );
      // }
      return const SizedBox.shrink();
    },
  );
}

  // method created to display a dialog box in order
  // for the user to see the summary of the game they played
  // Parameters:
    // context: passed in to provide access to other widgets
    // gameStateProvider: provides state of the game
  _gameFinished(BuildContext context, GameStateProvider gameStateProvider) {
    if (gameStateProvider.finished) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Summary of Game'),
            content: Text(
              'Game is Complete!\n\n'
              'Words Guessed Correctly: ${gameStateProvider.correct}\n'
              'Words Skipped: ${gameStateProvider.skipped}',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _restart(notify: true);
                },
                child: const FittedBox(child: Text('Restart Game', textAlign: TextAlign.center,)),
              ),
              TextButton(
                onPressed: () {
                  // close the dialog box
                  Navigator.of(context).pop();
                  // forcefully exit the app entirely
                  Navigator.pop(context);
                },
                child: const Text("Exit"),
              ),
            ],
          );
        }
      );
    }
  }

  // Method created to navigate user's to the drawing canvas page
  // and clears the canvas once a new term is set
  // Parameters:
    // context: passed in to provide access to other widgets
  _navigateToDrawing(BuildContext context) {
    final drawingProvider = Provider.of<DrawingProvider>(context, listen: false);
    drawingProvider.wipeDrawing();
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DrawView())
      );
    }
  }

  // Method created in order to restart the game by ensuring the game state
  // is reset
  void _restart({required bool notify}) {
    final gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
    // print(widget.time);
    gameStateProvider.refreshGameState(category: widget.category, newTime: widget.time, isar: widget.isar, notify: notify);
    
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (Timer time) {
    gameStateProvider.decrementTimer();
    });
  }
}