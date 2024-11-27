import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/providers/word_bank_provider.dart';
import 'package:brainrot/views/all_categories_view.dart'; // Ensure this is the correct import
import 'package:brainrot/views/create_word_view.dart';

class WordBankView extends StatelessWidget {
  final String categoryName;

  const WordBankView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to Categories',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllCategoriesView(), // Navigate to actual AllCategoriesView
              ),
            );
          },
        ),
        title: Text('$categoryName - Word Bank'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateWordView()),
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
      // Set the background color here
      backgroundColor: Colors.white, // Example: Light blue-grey background
      body: Consumer<WordBankProvider>(
        builder: (context, wordBankProvider, child) {
          final words = wordBankProvider.words;

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
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    final word = words[index];

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
                              // fontWeight: FontWeight.bold,
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
