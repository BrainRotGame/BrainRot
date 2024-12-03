import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/category.dart';
import 'package:brainrot/models/word.dart';
import 'package:brainrot/views/create_word_view.dart';

class WordBankView extends StatelessWidget {
  final Category category;

  const WordBankView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            header: true,
            label: '${category.categoryName} - Word Bank',
            excludeSemantics: false,
            child: Text('${category.categoryName} - Word Bank'),
          ),
          actions: [
            Semantics(
              label: 'Add a new word',
              button: true,
              child: IconButton(
                onPressed: () async {
                  // Create a new word with id = 0 for adding
                  final newWord = Word(
                    id: 0, // Placeholder ID for new words
                    wordName: '',
                    description: '',
                    hint: null,
                  );

                  final addedWord = await Navigator.push<Word>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateWordView(
                        word: newWord,
                        category: category,
                      ),
                    ),
                  );

                  if (addedWord != null) {
                    category.upsertCategory(addedWord);
                  }
                },
                icon: const Icon(Icons.add, size: 36),
                tooltip: 'Add New Word',
              ),
            ),
          ],
        ),
        body: Consumer<Category>(
          builder: (context, category, _) {
            final allWords = category.category;

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: allWords.length,
                    itemBuilder: (context, index) {
                      final word = allWords[index];

                      return Semantics(
                        label: 'Word: ${word.wordName}',
                        hint: word.hint != null && word.hint!.isNotEmpty
                            ? 'Hint: ${word.hint!}'
                            : 'No hint available',
                        button: true,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            final updatedWord = await Navigator.push<Word>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateWordView(
                                  word: word,
                                  category: category,
                                ),
                              ),
                            );

                            if (updatedWord != null) {
                              category.upsertCategory(updatedWord);
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                word.wordName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 30, color: Colors.black),
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
