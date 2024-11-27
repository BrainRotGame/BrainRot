import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/providers/word_bank_provider.dart';
import 'package:brainrot/views/word_bank_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WordBankProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brain Rot App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WordBankView(categoryName: 'Test Category'),
      ),
    );
  }
}
