// word name
// description
// hint(optional)

class Word {
  final int id;
  final String wordName;
  final String description;
  final String? hint;

  // constructor
  Word({
    required this.id,
    required this.wordName,
    required this.description,
    this.hint,
  });

  Word.withUpdatedData({
    required Word original,
    String? newWordName,
    String? newDescription,
    String? newHint,
  }) : id = original.id,
       wordName = newWordName ?? original.wordName,
       description = newDescription ?? original.description,
       hint = newHint ?? original.hint;

  @override
  String toString() {
    return 'Word(wordName: $wordName, description: $description, hint: $hint)';
  }
}