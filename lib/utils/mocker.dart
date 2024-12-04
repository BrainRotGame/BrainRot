import 'package:brainrot/models/category.dart';
import 'package:brainrot/models/collection.dart';
import 'package:brainrot/models/word.dart';

Collection gameMocker() {

  final animalsWords = [
    Word(
      id: 1,
      wordName: "Elephant",
      description: "A large mammal with a trunk and tusks.",
      hint: "Largest land animal.",
    ),
    Word(
      id: 2,
      wordName: "Penguin",
      description: "A flightless bird that lives in cold climates.",
      hint: "Loves ice and waddling.",
    ),
    Word(
      id: 3,
      wordName: "Tiger",
      description: "A big cat with orange fur and black stripes.",
      hint: "Fierce and striped.",
    ),
  ];

  final countriesWords = [
    Word(
      id: 4,
      wordName: "USA",
      description: "A North American country known as the land of opportunity.",
      hint: "Stars and stripes.",
    ),
    Word(
      id: 5,
      wordName: "France",
      description: "A European country known for the Eiffel Tower.",
      hint: "Home to the city of love.",
    ),
    Word(
      id: 6,
      wordName: "Japan",
      description: "An Asian country known for sushi and cherry blossoms.",
      hint: "Land of the rising sun.",
    ),
    Word(
      id: 7,
      wordName: "Brazil",
      description: "A South American country famous for its rainforests.",
      hint: "Carnival and football.",
    ),
  ];

  final fruitsWords = [
    Word(
      id: 8,
      wordName: "Apple",
      description: "A round fruit that is red, green, or yellow.",
      hint: "Keeps the doctor away.",
    ),
    Word(
      id: 9,
      wordName: "Banana",
      description: "A long, yellow fruit that is peeled before eating.",
      hint: "Monkeys love it.",
    ),
    Word(
      id: 10,
      wordName: "Cherry",
      description: "A small, round fruit that is typically red.",
      hint: "Often found on top of sundaes.",
    ),
  ];

  final holidayWords = [
    Word(
      id: 11,
      wordName: "Halloween",
      description: "Holiday known to dress up as something else",
      hint: "You might be scared of this holiday.",
    ),
    Word(
      id: 12,
      wordName: "New Years",
      description: "Celebration for the start of a new year",
      hint: "Midnight Countdown",
    ),
    Word(
      id: 13,
      wordName: "Christmas",
      description: "Celebration with the implementation of gift-giving and trees",
      hint: "Santa brings gifts.",
    ),
  ];

  final sportsWords = [
    Word(
      id: 14,
      wordName: "Soccer",
      description: "Popular sport against two teams kicking a ball into the goal",
      hint: "It's called something else outside of the U.S.",
    ),
    Word(
      id: 15,
      wordName: "Football",
      description: "Played by catching the ball with your hands as you score by crossing the opponent's field line",
      hint: "It's an oval ball",
    ),
    Word(
      id: 16,
      wordName: "Swimming",
      description: "A sport played to race in the water ",
      hint: "Involves water.",
    ),
  ];

  final hobbyWords = [
    Word(
      id: 17,
      wordName: "Drawing",
      description: "Use of pencils and other tools to create and display an image",
      hint: "What would you do with a blank paper and tools.",
    ),
    Word(
      id: 18,
      wordName: "Playing a musical instrument",
      description: "Use of an instrument to create different, unique sounds",
      hint: "Making melodies, different tones and sounds",
    ),
    Word(
      id: 19,
      wordName: "Knitting",
      description: "Use of yarn to create a variety of clothing items and more",
      hint: "Gives you something warm to wear.",
    ),
  ];

  final animalsCategory = Category(categoryName: "Animals", words: animalsWords);
  final fruitsCategory = Category(categoryName: "Fruits", words: fruitsWords);
  final countriesCategory = Category(categoryName: "Countries", words: countriesWords);
  final holidayCategory = Category(categoryName: "Holidays", words: holidayWords);
  final sportsCategory = Category(categoryName: "Sports", words: sportsWords);
  final hobbyCategory = Category(categoryName: "Hobbies", words: hobbyWords);

  final gameCollection = Collection();

  gameCollection.upsertCategory(animalsCategory);
  gameCollection.upsertCategory(fruitsCategory);
  gameCollection.upsertCategory(countriesCategory);
  gameCollection.upsertCategory(holidayCategory);
  gameCollection.upsertCategory(sportsCategory);
  gameCollection.upsertCategory(hobbyCategory);



  return gameCollection;
}

