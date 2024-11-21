import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/views/game_views/game_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

