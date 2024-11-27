import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/category.dart';
import 'package:brainrot/providers/word_bank_provider.dart';
import 'package:brainrot/views/create_word_view.dart';

class WordBankView extends StatelessWidget {
  final Category category;

  const WordBankView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.categoryName} - Word Bank'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateWordView(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 36,
            ),
            tooltip: 'Add New Word',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<WordBankProvider>(
        builder: (context, wordBankProvider, _) {
          final allWords = [
            ...category.category,
            ...wordBankProvider.words,
          ];
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    crossAxisSpacing: 30, // Space between columns
                    mainAxisSpacing: 20, // Space between rows
                    childAspectRatio: 2.5, // Adjust the box shape
                  ),
                  itemCount: allWords.length,
                  itemBuilder: (context, index) {
                    final word = allWords[index];
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateWordView(
                              word: word,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            word.wordName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          if (word.hint != null && word.hint!.isNotEmpty)
                            Text(
                              'Hint: ${word.hint!}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Add play functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                  child: const Text(
                    'PLAY!',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}