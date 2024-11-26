import 'package:brainrot/providers/drawing_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/utils/mocker.dart';
// import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/views/game_views/game_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrawingProvider(width: 800, height: 400)),
        ChangeNotifierProvider(create: (context) => GameStateProvider(time: 0, words: gameMocker().collection[0].category,
        collectionView: gameMocker()))
      ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Brain Rot App',
      home: GameView()
    );
  }
}

