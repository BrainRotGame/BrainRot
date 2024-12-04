import 'package:flutter/material.dart';
import 'package:brainrot/models/word.dart';
import 'package:brainrot/models/category.dart';

class CreateWordView extends StatefulWidget {
  final Word word; // Existing word to edit (null for a new word)
  final int? index; // Index of the word in the list
  final Category category; // The category this word belongs to

  const CreateWordView({super.key, required this.word, this.index, required this.category});

  @override
  State<CreateWordView> createState() => _CreateWordViewState();
}

class _CreateWordViewState extends State<CreateWordView> {
  // Local state variables for the form fields
  String currentWordName = '';
  String currentDescription = '';
  String currentHint = '';
  bool error = false;

  @override
  void initState() {
    super.initState();

    // Initialize state variables with existing data (if editing)
    currentWordName = widget.word.wordName;
    currentDescription = widget.word.description;
    currentHint = widget.word.hint ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    final isEditing = widget.word != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Word' : 'Create Word'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Semantics(
              label: 'Enter the word name',
              child: TextFormField(
                initialValue: currentWordName,
                decoration: const InputDecoration(labelText: 'Word Name'),
                onChanged: (value) {
                  setState(() {
                    currentWordName = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'Description Input Field',
              child: TextFormField(
                initialValue: currentDescription,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  setState(() {
                    currentDescription = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: 'enter hint',
              child: TextFormField(
                initialValue: currentHint,
                decoration: const InputDecoration(labelText: 'Hint (Optional)'),
                onChanged: (value) {
                  setState(() {
                    currentHint = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Semantics(
              label: isEditing ? 'Update Word Button' : 'Save Word Button',
              button: true,
              child: ElevatedButton(
                onPressed: () => _saveAndPop(context),
                child: Text(isEditing ? 'Update Word' : 'Save Word'),
              ),
            ),
            if(error)
            const Padding(padding: EdgeInsets.all(5),child: Text('Cannot update term without a name or description'))
          ],
        ),
      ),
    );
  }

  /// Handles saving or updating the word and pops back to the previous screen.
  void _saveAndPop(BuildContext context) async {
    if(currentWordName.trim().isNotEmpty && currentDescription.trim().isNotEmpty) {
      final updatedWord = Word.withUpdatedData(original: widget.word, newWordName: currentWordName, newDescription: currentDescription, newHint: currentHint);
      // final updatedWord = Word(
      //   id: null,
      //   wordName: currentWordName,
      //   description: currentDescription,
      //   hint: currentHint.isNotEmpty ? currentHint : null,
      // );

      Navigator.pop(context, updatedWord);
    }
    else {
      setState(() {
        error = true;
      });
    }
    
  }
}
