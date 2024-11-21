// word name
// description
// hint(optional)

class Word {
  final String wordName;
  final String description;
  final String? hint;

  // constructor
  Word({
    required this.wordName,
    required this.description,
    this.hint,
  });
}