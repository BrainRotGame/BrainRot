import 'package:brainrot/models/category.dart';
import 'package:brainrot/models/word.dart';
// import 'package:brainrot/providers/word_bank_provider.dart';
import 'package:brainrot/providers/game_state_provider.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/providers/collection_provider.dart';
import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
   final isar = await Isar.open([CategorySchema, WordSchema], directory: dir.path);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollectionProvider(isar: isar)),
        // ChangeNotifierProvider(create: (_) => WordBankProvider()),
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
        ChangeNotifierProvider(create: (_) => DrawingProvider(width: 800, height: 400)),
      ],
      child: MyApp(isar: isar),
    ),
  );
  SemanticsBinding.instance.ensureSemantics();
}

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brainrot Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllCategoriesView(isar: isar),
    );
  }
}
