import 'package:brainrot/providers/drawing_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/views/game_views/draw_area.dart';
import 'package:brainrot/views/game_views/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Object represents the drawing UI
//Contains a canvas that users can freely draw to their customization and displays the game status
class DrawView extends StatelessWidget {
  // const DrawView({super.key, required this.width, required this.height, required this.correct, required this.skipped});

  // final int correct;
  // final int skipped;

  const DrawView({super.key});
  // final GameStateProvider provider;

  @override
  Widget build(BuildContext context) {
    // final gameProvider = Provider.of<GameStateProvider>(context, listen: false);
    
    return Consumer<GameStateProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.time == 0) {
          _popBack(context);
        }
        String wordHint = 'No Hint Available';
        if(gameProvider.words[0].hint != null && gameProvider.words[0].hint!.isNotEmpty) {
          wordHint = gameProvider.words[0].hint!;
        }
        return MaterialApp(
          home: Scaffold(
            appBar:
                AppBar(title: const Text('Drawing Display'), actions: <Widget>[
                  Semantics(label: 'Clear all button',excludeSemantics: true, child: IconButton(tooltip: 'Clear', key: const Key('Clear'), iconSize: 30, onPressed: () => _clear(context), icon: const Icon(Icons.clear))),
                  Semantics(label: 'Undo button',excludeSemantics: true, child: IconButton(tooltip: 'Undo', key: const Key('Undo'), iconSize: 30, onPressed: () => _undo(context), icon: const Icon(Icons.undo))),
                  Semantics(label: 'Redo button',excludeSemantics: true, child: IconButton(tooltip: 'Redo', key: const Key('Redo'), iconSize: 30, onPressed: () => _redo(context), icon: const Icon(Icons.redo))),
            ]),
            drawer: Drawer(
              child: Palette(context, key: const Key('Palette')),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 197, 235, 253),
                      ),
                      child: Column(children: [
                        Text('Time Remaining: ${(gameProvider.time / 60).floor()}:${(gameProvider.time % 60).toString().padLeft(2,'0')}', style: const TextStyle(fontSize: 15),),
                        Text('Correct Guesses: ${gameProvider.correct}',  style: const TextStyle(fontSize: 15)),
                        Text('Skipped: ${gameProvider.skipped}',  style: const TextStyle(fontSize: 15)),
                      ],)),
                        // Text('Correct Guesses: ${gameProvider.time}'),
                        // Text('Correct Guesses: $correct'),
                        // Text('Skipped: $skipped'),],)),
                  ),
                  if(gameProvider.hint)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 192, 235, 255)
                      ),
                      child: Text(wordHint)
                      ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Semantics(
                        label: 'toggle hint button',
                        excludeSemantics: true,
                        child: IconButton(
                          iconSize: 30,
                          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 192, 235, 255)), foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 36, 36, 36))),
                          onPressed: () {
                            gameProvider.toggleHint();
                          }, 
                          icon: const Icon(Icons.question_mark)),
                      )
                      ),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: const DrawArea(width: 800, height: 400),
                  ),
                  
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Semantics(
                      label: 'Back button',
                      excludeSemantics: true,
                      child: ElevatedButton(
                        onPressed: () => _popBack(context),
                        style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 192, 235, 255)), foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 36, 36, 36))),
                        child: const Icon(Icons.arrow_back, size: 30,)))
                      // child: IconButton(key: const Key('Back'), iconSize: 30, onPressed: () => _popBack(context), icon: const Icon(Icons.arrow_back)))
                    ),
                ]
              ),
            ),
          ),
        );
      },
    );
  }

  //Method will clear the drawing on the canvas
  //@param: takes in a BuildContext
  void _clear(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).clear();
  }

  //Method will undo the latest draw action on the canvas
  //@param: takes in a BuildContext
  void _undo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).undo();
  }

  //Method will undo the latest undo action on the canvas
  //@param: takes in a BuildContext
  void _redo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).redo();
  }

  //Method will pop the current view back to the game view
  //@param: takes in a BuildContext
  _popBack(BuildContext context) {
    Provider.of<GameStateProvider>(context,listen: false).hint = false;
    Navigator.pop(context);
  }


}