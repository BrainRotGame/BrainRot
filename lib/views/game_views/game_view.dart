// import 'dart:math';

import 'dart:async';

import 'package:brainrot/models/category.dart';
import 'package:brainrot/providers/game_state_provider.dart';
// import 'package:brainrot/utils/mocker.dart';
// import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:io';

class GameView extends StatefulWidget {
  final Category category;
  final int time;

  const GameView({super.key, required this.time, required this.category});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final Timer _gameTimer;
  

  @override
  void initState() {
    super.initState();
    _sensorView();

    final singleUseGameProvider = Provider.of<GameStateProvider>(context, listen: false);
    singleUseGameProvider.changeCategory(widget.category.category);
    singleUseGameProvider.setTime(widget.time);
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (Timer time) {
      singleUseGameProvider.decrementTimer();
    });
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
                  child: const Text("Guessed Correct"),
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
                            Text('Time Remaining: ${gameStateProvider.time}'),
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
                  child: const Text("Skip"),
                ),
              ],
            ),
          ),
        );
      } else {
        return const Scaffold(
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('FINISHED'),
          ),
        );
      }
    },
  );
}

  // method created to display a dialog box in order
  // for the user to see the summary of the game they played
  _gameFinished(BuildContext context, GameStateProvider gameStateProvider) {
    if (gameStateProvider.finished) {
      showDialog(
        context: context,
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
                  gameStateProvider.refreshGameState(null);
                },
                child: const Text('Restart Game', textAlign: TextAlign.center,),
              ),
              TextButton(
                onPressed: () {
                  // close the dialog box
                  Navigator.of(context).pop();
                  // forcefully exit the app entirely
                  exit(0);
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
    if (context.mounted) {
      final gameStateProvider = Provider.of<GameStateProvider>(context, listen:false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DrawView(width: 800, height: 400, provider: gameStateProvider,)));
          // builder: (context) => DrawView(width: 800, height: 400, correct: gameStateProvider.correct, skipped: gameStateProvider.skipped)));
    }
  }
}