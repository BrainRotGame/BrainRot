import 'package:brainrot/providers/collection_provider.dart';
import 'package:brainrot/views/word_bank_view.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/category.dart';
import 'package:brainrot/views/game_views/game_view.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key, required this.isar});
  final Isar isar;

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 213, 187, 177),
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                label: 'Enter a new category name',
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Enter category name'),
                ),
              ),
              Semantics(
                button: true,
                label: 'Save category',
                hint: 'Saves the entered category name',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 231, 109, 131)),
                  onPressed: () {
                    final categoryName = controller.text.trim();
                    if (categoryName.isNotEmpty) {
                      Provider.of<CollectionProvider>(context, listen: false)
                          .addCategory(categoryName);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.black,)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryPopup(BuildContext context, Category category, bool error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if(error) {
          return const AlertDialog(
            backgroundColor:Color.fromARGB(255, 213, 187, 177),
            title: Text('Cannot play game - Category is empty. '),
        );
        }
        else {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 213, 187, 177),
            title: Text('You selected "${category.categoryName}"', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            content: const Text('Pick a timer', style: TextStyle(fontSize: 20)),
            actions: [
              Semantics(
                button: true,
                label: 'Cancel',
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel', style: TextStyle(color: Colors.black),),
                ),
              ),
              Semantics(
                button: true,
                label: 'Start a 1-minute game',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 231, 109, 131)),
                  onPressed: () {
                    navigateGame(context: context, category: category, time: 5); 
                  },
                  child: const Text('1 min', style: TextStyle(color: Colors.black)),
                ),
              ),
              Semantics(
                button: true,
                label: 'Start a 2-minute game',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 231, 109, 131)),
                  onPressed: () => navigateGame(context: context, category: category, time: 120),
                  child: const Text('2 min', style: TextStyle(color: Colors.black)),
                ),
              ),
              Semantics(
                button: true,
                label: 'Start a 5-minute game',
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 231, 109, 131)),
                  onPressed: () => navigateGame(context: context, category: category, time: 300), //TODO RESET 5MINS
                  child: const Text('5 min', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CollectionProvider>(context).categories;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 61, 63),
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: const Color.fromARGB(255, 213, 187, 177),
        title: const Text('Brain Rot', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
        actions: [
          Semantics(
            button: true,
            label: 'Add a new category',
            excludeSemantics: true,
            child: IconButton(
              tooltip: 'Add New Category',
              icon: const Icon(Icons.add),
              iconSize: 40,
              onPressed: () => _showAddCategoryDialog(context),
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
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Tooltip(
            message: 'Tap to play game. Press & hold to edit category',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 231, 109, 131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Color.fromARGB(255, 77, 77, 77)),
                ),
              ),
              onPressed: () {
              if(category.getWords(isar).isNotEmpty) {
                _showCategoryPopup(context, category, false);
                }
              else {
                _showCategoryPopup(context, category, true);
              }
              },
              onLongPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WordBankView(isar: isar, category: category),
                  ),
                );
              },
              child: FittedBox(
                child: Text(
                    category.categoryName,
                    style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //     borderRadius: BorderRadius.circular(5),
              //   ),
                
              // ),
            ),
          );
        },
      ),
    );
  }

  void navigateGame({required BuildContext context, required Category category, required int time}) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GameView(
          isar: isar,
          category: category,
          time: time,
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
          backgroundColor: Color.fromARGB(255, 213, 187, 177),
          title: Text('Help Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
          content: Align(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap the + button to add a new category.', style: TextStyle(fontSize: 20),))),
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap & hold a category to edit their word bank.', style: TextStyle(fontSize: 20)))),
                Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.centerLeft, child: Text('- Tap a category to play a game.', style: TextStyle(fontSize: 20)))),
              ],
            ),
          )
        );
      },
    );
  }
}
