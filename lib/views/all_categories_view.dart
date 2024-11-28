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
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Enter category name'),
              ),
              ElevatedButton(
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
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // implement here to jump to game view
                // Navigator.of(context).pop();
                navigateGame(context: context, category: category, time: 60);
              },
              child: const Text('1 min'),
            ),
            ElevatedButton(
              onPressed: () => navigateGame(context: context, category: category, time: 120),
              child: const Text('2 min'),
            ),
            ElevatedButton(
              onPressed: () => navigateGame(context: context, category: category, time: 300),
              child: const Text('5 min'),
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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(context),
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
          time: time
        )
      )
    );
  }
}
