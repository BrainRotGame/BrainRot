import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:io';
class GameView extends StatefulWidget {

  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {

  @override
  void initState() {
    super.initState();
    _sensorView();
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
          return Scaffold(
            backgroundColor: Colors.lightBlue[100],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(onPressed: () => gameStateProvider.incrementCorrect(),
                  child: const Text("Guessed Correct")),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          Text('Correct Guesses: ${gameStateProvider.correct}'),
                          Text('Skipped: ${gameStateProvider.skipped}'),
                        ],),
                      ),
                      // const SizedBox(width: 300),
                      const Expanded(child: SizedBox()),
                      const Text("TEXT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                      const Expanded(child: SizedBox()),
                      // const SizedBox(width: 300),
                      ElevatedButton(onPressed: () => _navigateToDrawing(context),
                      child: const Text("Navigate to drawing")),
                    ]

                  ),
                ),

                  ElevatedButton(onPressed: () => gameStateProvider.incrementSkip(),
                  child: const Text("Skip")),
              ],
            ),
          ),
        );
      }

    );
  }

  _navigateToDrawing(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DrawView(
            width: 800, height: 400)));
    }
  }
}