import 'package:flutter/material.dart';
import 'package:brainrot/models/category.dart';

class WordBankView extends StatelessWidget {
  final Category category;

  const WordBankView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.categoryName} Words'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.0, // Spacing between columns
            mainAxisSpacing: 10.0, // Spacing between rows
            childAspectRatio: 3, // Aspect ratio of each grid item
          ),
          itemCount: category.category.length,
          itemBuilder: (context, index) {
            final word = category.category[index];
            return GestureDetector(
              onTap: () {
                // Handle word tap (e.g., show details or perform an action)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected "${word.wordName}"')),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  word.wordName,
                  style: const TextStyle(color: Colors.white, fontSize: 32.0),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
