import 'package:brainrot/providers/word_bank_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/providers/collection_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollectionProvider()),
        ChangeNotifierProvider(create: (_) => WordBankProvider()),
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
        ChangeNotifierProvider(create: (_) => DrawingProvider(width: 800, height: 400)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brainrot Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AllCategoriesView(),
    );
  }
}
