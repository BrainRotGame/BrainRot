import 'package:brainrot/models/category.dart';
import 'package:brainrot/models/collection.dart';
import 'package:brainrot/models/word.dart';

Collection gameMocker() {

  final animalsWords = [
    Word(
      wordName: "Elephant",
      description: "A large mammal with a trunk and tusks.",
      hint: "Largest land animal.",
    ),
    Word(
      wordName: "Penguin",
      description: "A flightless bird that lives in cold climates.",
      hint: "Loves ice and waddling.",
    ),
    Word(
      wordName: "Tiger",
      description: "A big cat with orange fur and black stripes.",
      hint: "Fierce and striped.",
    ),
  ];

  final countriesWords = [
    Word(
      wordName: "USA",
      description: "A North American country known as the land of opportunity.",
      hint: "Stars and stripes.",
    ),
    Word(
      wordName: "France",
      description: "A European country known for the Eiffel Tower.",
      hint: "Home to the city of love.",
    ),
    Word(
      wordName: "Japan",
      description: "An Asian country known for sushi and cherry blossoms.",
      hint: "Land of the rising sun.",
    ),
    Word(
      wordName: "Brazil",
      description: "A South American country famous for its rainforests.",
      hint: "Carnival and football.",
    ),
  ];

  final fruitsWords = [
    Word(
      wordName: "Apple",
      description: "A round fruit that is red, green, or yellow.",
      hint: "Keeps the doctor away.",
    ),
    Word(
      wordName: "Banana",
      description: "A long, yellow fruit that is peeled before eating.",
      hint: "Monkeys love it.",
    ),
    Word(
      wordName: "Cherry",
      description: "A small, round fruit that is typically red.",
      hint: "Often found on top of sundaes.",
    ),
  ];

  final animalsCategory = Category(categoryName: "Animals", words: animalsWords);
  final fruitsCategory = Category(categoryName: "Fruits", words: fruitsWords);
  final countriesCategory = Category(categoryName: "Countries", words: countriesWords);

  final gameCollection = Collection();

  gameCollection.upsertCategory(animalsCategory);
  gameCollection.upsertCategory(fruitsCategory);
  gameCollection.upsertCategory(countriesCategory);

  return gameCollection;
}

