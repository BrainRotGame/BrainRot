import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/word.dart';
import 'package:brainrot/providers/word_bank_provider.dart';

class CreateWordView extends StatefulWidget {
  final Word? word;
  final int? index;

  const CreateWordView({super.key, this.word, this.index});

  @override
  State<CreateWordView> createState() => _CreateWordViewState();
}

class _CreateWordViewState extends State<CreateWordView> {
  late TextEditingController _wordNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _hintController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing word data (if editing) or empty strings
    _wordNameController = TextEditingController(text: widget.word?.wordName ?? '');
    _descriptionController = TextEditingController(text: widget.word?.description ?? '');
    _hintController = TextEditingController(text: widget.word?.hint ?? '');
  }

  @override
  void dispose() {
    _wordNameController.dispose();
    _descriptionController.dispose();
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.word != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Word' : 'Create Word'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _wordNameController,
              decoration: const InputDecoration(
                labelText: 'Word Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hintController,
              decoration: const InputDecoration(
                labelText: 'Hint (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final word = Word(
                  wordName: _wordNameController.text,
                  description: _descriptionController.text,
                  hint: _hintController.text.isNotEmpty ? _hintController.text : null,
                );

                final wordBankProvider = Provider.of<WordBankProvider>(context, listen: false);

                if (isEditing && widget.index != null) {
                  wordBankProvider.updateWord(widget.index!, word);
                } else {
                  wordBankProvider.addWord(word);
                }

                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Update Word' : 'Save Word'),
            ),
          ],
        ),
      ),
    );
  }
}
