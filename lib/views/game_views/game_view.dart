import 'package:brainrot/views/game_views/draw_view.dart';
import 'package:flutter/material.dart';

class GameView extends StatelessWidget {

  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () => _navigateToDrawing(context), 
          child: const Text("Guessed Correct")),
        ElevatedButton(onPressed: () => _navigateToDrawing(context), 
          child: const Text("Navigate to drawing")),
          ElevatedButton(onPressed: () => _navigateToDrawing(context), 
          child: const Text("Skip")),
      ],
      
    );
  }
  
  _navigateToDrawing(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DrawView(width: 800, height: 400)));
  }
}