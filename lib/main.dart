import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/views/all_categories_view.dart';
import 'package:brainrot/providers/collection_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollectionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
