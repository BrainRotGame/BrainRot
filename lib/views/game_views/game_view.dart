import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {

  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (context, gameStateProvider, child) {
          return Scaffold(
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
                          color: const Color.fromARGB(255, 197, 235, 253),
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
  
  _navigateToDrawing(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawView(width: 800, height: 400)));
  }
}