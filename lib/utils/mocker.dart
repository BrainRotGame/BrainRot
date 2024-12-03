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
    Word(
      id: 11,
      wordName: "Kangaroo",
      description: "A marsupial native to Australia that hops on two legs.",
      hint: "Famous for its pouch.",
    ),
    Word(
      id: 12,
      wordName: "Dolphin",
      description: "A highly intelligent marine mammal.",
      hint: "Known for its playful nature.",
    ),
    Word(
      id: 17,
      wordName: "Giraffe",
      description: "A tall mammal with a long neck, native to Africa.",
      hint: "Tallest animal.",
    ),
    Word(
      id: 18,
      wordName: "Lion",
      description: "Known as the king of the jungle.",
      hint: "Roars loudly.",
    ),
    Word(
      id: 19,
      wordName: "Panda",
      description: "A black and white bear that eats bamboo.",
      hint: "Cute and cuddly.",
    ),
    Word(
      id: 20,
      wordName: "Koala",
      description: "An Australian marsupial that loves eucalyptus leaves.",
      hint: "Often mistaken for a bear.",
    ),
    Word(
      id: 21,
      wordName: "Sloth",
      description: "A slow-moving animal that hangs from trees.",
      hint: "Lazy and slow.",
    ),
    Word(
      id: 22,
      wordName: "Whale",
      description: "The largest animal in the ocean.",
      hint: "Lives in the sea and spouts water.",
    ),
    Word(
      id: 23,
      wordName: "Fox",
      description: "A cunning animal with a bushy tail.",
      hint: "What does it say?",
    ),
    Word(
      id: 24,
      wordName: "Wolf",
      description: "A wild canine known for its howls.",
      hint: "Often in packs.",
    ),
    Word(
      id: 25,
      wordName: "Cheetah",
      description: "The fastest land animal.",
      hint: "Spotted sprinter.",
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
    Word(
      id: 13,
      wordName: "India",
      description: "A country known for its diverse culture and spicy cuisine.",
      hint: "Land of the Taj Mahal.",
    ),
    Word(
      id: 14,
      wordName: "Canada",
      description: "A North American country known for its maple syrup.",
      hint: "Friendly neighbors to the USA.",
    ),
    Word(
      id: 26,
      wordName: "Australia",
      description: "A country known for kangaroos and the Sydney Opera House.",
      hint: "Down under.",
    ),
    Word(
      id: 27,
      wordName: "Germany",
      description: "A European country known for its beer and bratwurst.",
      hint: "Home of Oktoberfest.",
    ),
    Word(
      id: 28,
      wordName: "Russia",
      description: "The largest country in the world by area.",
      hint: "Land of cold winters.",
    ),
    Word(
      id: 29,
      wordName: "Italy",
      description: "A country known for its pizza, pasta, and ancient ruins.",
      hint: "Shaped like a boot.",
    ),
    Word(
      id: 30,
      wordName: "Mexico",
      description: "A country known for tacos and mariachi music.",
      hint: "South of the USA.",
    ),
    Word(
      id: 31,
      wordName: "China",
      description: "A country with the Great Wall and pandas.",
      hint: "Most populous nation.",
    ),
    Word(
      id: 32,
      wordName: "Egypt",
      description: "Known for the pyramids and the Nile River.",
      hint: "Land of the pharaohs.",
    ),
    Word(
      id: 33,
      wordName: "South Africa",
      description: "Known for safaris and Nelson Mandela.",
      hint: "At the southern tip of a continent.",
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
    Word(
      id: 15,
      wordName: "Mango",
      description: "A juicy tropical fruit with a large pit.",
      hint: "King of fruits.",
    ),
    Word(
      id: 16,
      wordName: "Strawberry",
      description: "A red, heart-shaped fruit with tiny seeds on the outside.",
      hint: "Sweet and often found in desserts.",
    ),
    Word(
      id: 34,
      wordName: "Pineapple",
      description: "A tropical fruit with a spiky skin and sweet interior.",
      hint: "Goes on pizza?",
    ),
    Word(
      id: 35,
      wordName: "Orange",
      description: "A citrus fruit with a tough skin and juicy interior.",
      hint: "Vitamin C powerhouse.",
    ),
    Word(
      id: 36,
      wordName: "Watermelon",
      description: "A large, green fruit with sweet red flesh inside.",
      hint: "Great for summer picnics.",
    ),
    Word(
      id: 37,
      wordName: "Peach",
      description: "A sweet fruit with fuzzy skin.",
      hint: "Georgia is famous for it.",
    ),
    Word(
      id: 38,
      wordName: "Blueberry",
      description: "A small, blue fruit that's popular in muffins.",
      hint: "Great in pies.",
    ),
    Word(
      id: 39,
      wordName: "Grapes",
      description: "Small fruits that grow in bunches.",
      hint: "Used to make wine.",
    ),
    Word(
      id: 40,
      wordName: "Pear",
      description: "A green or yellow fruit with a bell shape.",
      hint: "Sweet and juicy.",
    ),
    Word(
      id: 41,
      wordName: "Plum",
      description: "A purple or red stone fruit.",
      hint: "Great dried as prunes.",
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
