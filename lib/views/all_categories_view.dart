import 'package:brainrot/providers/collection_provider.dart';
import 'package:brainrot/views/word_bank_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brainrot/models/category.dart';
import 'package:brainrot/views/game_views/game_view.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});

  void _showAddCategoryDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
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
                  onPressed: () {
                    final categoryName = controller.text.trim();
                    if (categoryName.isNotEmpty) {
                      Provider.of<CollectionProvider>(context, listen: false)
                          .addCategory(categoryName);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategoryPopup(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You selected "${category.categoryName}"'),
          content: const Text('Pick a timer'),
          actions: [
            Semantics(
              button: true,
              label: 'Cancel',
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
            Semantics(
              button: true,
              label: 'Start a 1-minute game',
              child: ElevatedButton(
                onPressed: () {
                  navigateGame(context: context, category: category, time: 60);
                },
                child: const Text('1 min'),
              ),
            ),
            Semantics(
              button: true,
              label: 'Start a 2-minute game',
              child: ElevatedButton(
                onPressed: () => navigateGame(context: context, category: category, time: 120),
                child: const Text('2 min'),
              ),
            ),
            Semantics(
              button: true,
              label: 'Start a 5-minute game',
              child: ElevatedButton(
                onPressed: () => navigateGame(context: context, category: category, time: 10),
                child: const Text('5 min'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CollectionProvider>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          Semantics(
            button: true,
            label: 'Add a new category',
            child: IconButton(
              tooltip: 'Add New Category',
              icon: const Icon(Icons.add),
              onPressed: () => _showAddCategoryDialog(context),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => _showCategoryPopup(context, category),
            onLongPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WordBankView(category: category),
                ),
              );
            },
            child: Semantics(
              label: 'Category: ${category.categoryName}',
              hint: 'Tap to start the game. Long press to view the word bank',
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  category.categoryName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
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
          category: category,
          time: time,
        ),
      ),
    );
  }
}
