// word name
// description
// hint(optional)

class Word {
  final String word;
  final String description;
  final String? hint;

  Word({
    required this.word,
    required this.description,
    this.hint,
  });
}