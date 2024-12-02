// import 'dart:math';

import 'dart:async';

import 'package:brainrot/models/category.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
// import 'package:brainrot/utils/mocker.dart';
// import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:io';

class GameView extends StatefulWidget {
  final Isar isar;
  final Category category;
  final int time;
  

  const GameView({super.key, required this.isar, required this.time, required this.category});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late Timer _gameTimer;
  

  @override
  void initState() {
    super.initState();
    _sensorView();

    _restart();
  }

  @override
  void dispose() {
    _gameTimer.cancel();
    super.dispose();
  }

@override
// ensuring context and widget tree are available
// in which they can be accessed
void didChangeDependencies() {
  super.didChangeDependencies();
  // called once we know that the context has been initialized
  _sensorView();  // Start listening after context is available
}
  void _sensorView() {
      if (Platform.isAndroid || Platform.isIOS) {
    accelerometerEvents.listen((AccelerometerEvent e) {
      // ignore: use_build_context_synchronously
      final gameStateProvider = Provider.of<GameStateProvider>(context, listen:false);
      // z -> axis representing front to back, x(left to right), y(top to bottom)
      // 9.5 -> threshold set to detect movement with device (facing upward if +9.5, and downward -9.5)
      // motion of sensor moving up, increment correct
      if (e.z > 9.5) {
        gameStateProvider.incrementCorrect();
      } else if (e.z < -9.5) { // motion of sensor moving down, increment skip
        gameStateProvider.incrementSkip();
      }
    });
    }
  }

  @override
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
                    Icon(Icons.arrow_upward_rounded),
                    Text('Flip up or tap for guessing correctly'),
                    Icon(Icons.arrow_upward_rounded),
                  ],)
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text('Time Remaining: ${(gameStateProvider.time / 60).floor()}:${(gameStateProvider.time % 60).toString().padLeft(2,'0')}'),
                            Text('Correct Guesses: ${gameStateProvider.correct}'),
                            Text('Skipped: ${gameStateProvider.skipped}'),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Text(gameStateProvider.words[0].wordName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () => _navigateToDrawing(context),
                        child: const Text("Navigate to drawing"),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => gameStateProvider.incrementSkip(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.arrow_downward_rounded),
                    Text('Flip down or tap for guessing correctly'),
                    Icon(Icons.arrow_downward_rounded),
                  ],)
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
  _gameFinished(BuildContext context, GameStateProvider gameStateProvider) {
    // if(_currDrawing) {
    //   _currDrawing = false;
    //   Navigator.pop(context);
    // }
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
                  _restart();
                },
                child: const Text('Restart Game', textAlign: TextAlign.center,),
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

  _navigateToDrawing(BuildContext context) {
    // await Future.delayed(const Duration(seconds: 1));
    final drawingProvider = Provider.of<DrawingProvider>(context, listen: false);
    drawingProvider.wipeDrawing(); //TODO only wipe drawing on a new term
    
    if (context.mounted) {
      // final gameStateProvider = Provider.of<GameStateProvider>(context, listen:false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DrawView(width: 800, height: 400))
          );
          // builder: (context) => DrawView(width: 800, height: 400, correct: gameStateProvider.correct, skipped: gameStateProvider.skipped)));
    }
  }
  
  void _restart() {
    // _gameTimer.cancel();
    final gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
    // print(widget.time);
    gameStateProvider.refreshGameState(category: widget.category, newTime: widget.time, isar: widget.isar);
    
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (Timer time) {
      // print('test');
      gameStateProvider.decrementTimer();
    });
  }
}