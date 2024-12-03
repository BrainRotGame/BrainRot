import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/category.dart';
import 'package:brainrot/models/word.dart';
import 'package:brainrot/views/create_word_view.dart';

class WordBankView extends StatelessWidget {
  final Category category;
  final Isar isar;

  const WordBankView({super.key, required this.category, required this.isar});
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: category,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${category.categoryName} - Word Bank'),
          actions: [
            IconButton(
              onPressed: () async {
                // Create a new word with new id for adding
                final newWord = Word(
                  id: null,
                  wordName: '',
                  description: '',
                  hint: null,
                );
                category.upsertWord(isar: isar, word: newWord);

                final addedWord = await Navigator.push<Word>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateWordView(
                      word: newWord,
                      category: category,
                    ),
                  ),
                );

                if (addedWord == null || addedWord.wordName.isEmpty) {
                  category.removeWord(isar: isar, word: newWord);
                  // print(category.loadWords(isar));
                }
                else {
                  category.upsertWord(isar: isar, word: addedWord);
                }
              },
              icon: const Icon(Icons.add, size: 36),
              tooltip: 'Add New Word',
            ),
          ],
        ),
        body: Consumer<Category>(
          builder: (context, category, _) {
            final allWords = category.getWords(isar);
            // print(allWords);

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

                      return ElevatedButton(
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
                            category.upsertWord(isar: isar, word: updatedWord);
                            // print(category.loadWords(isar));
                          }
                        },
                        onLongPress: () {
                          category.removeWord(isar: isar, word: word);
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
