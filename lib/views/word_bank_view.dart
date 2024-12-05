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
          title: Semantics(
            header: true,
            label: '${category.categoryName} - Word Bank',
            excludeSemantics: false,
            child: Text('${category.categoryName} - Word Bank'),
          ),
          actions: [
            Semantics(
              label: 'Add word button',
              excludeSemantics: true,
              button: true,
              child: IconButton(
                onPressed: () async {
                  // Create a new word with new id for adding
                  final newWord = Word(
                    id: null,
                    wordName: '',
                    description: '',
                    hint: null,
                  );
                  category.upsertWord(isar: isar, word: newWord, notify: true);
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
                    category.upsertWord(isar: isar, word: addedWord, notify: true);
                  }
                },
                icon: const Icon(Icons.add, size: 36),
                tooltip: 'Add New Word',
              ),
            ),
            Semantics(
            button: true,
            label: 'Help button',
            excludeSemantics: true,
            child: IconButton(
              tooltip: 'Help',
              icon: const Icon(Icons.question_mark),
              iconSize: 25,
              onPressed: () => _showHelp(context),
            ),
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

                      return Semantics(
                        label: 'Word: ${word.wordName}',
                        hint: word.hint != null && word.hint!.isNotEmpty
                            ? 'Hint: ${word.hint}'
                            : 'No hint available',
                        button: true,
                        child: Tooltip(
                          message: 'Tap to edit term. Tap & hold to delete term',
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
                                category.upsertWord(isar: isar, word: updatedWord, notify: true);
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
                                  overflow: TextOverflow.ellipsis
                                ),
                                if (word.hint != null && word.hint!.isNotEmpty)
                                  Text(
                                    'Hint: ${word.hint!}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                              ],
                            ),
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
  
    //method will display a Dialog box of a help menu
  //@param: takes in a BuildContext
  _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Help Info'),
          content: Align(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap the + button to add a new Word with a description and hint.'))),
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap a word to edit it.'))),
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap & hold a word to delete it.'))),
                
              ],
            ),
          )
        );
      },
    );
  }
}
