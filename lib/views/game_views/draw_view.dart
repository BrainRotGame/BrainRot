import 'package:brainrot/providers/drawing_provider.dart';
import 'package:brainrot/views/game_views/draw_area.dart';
import 'package:brainrot/views/game_views/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawView extends StatelessWidget {
  const DrawView({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
            AppBar(title: const Text('Drawing Display'), actions: <Widget>[
              Semantics(label: 'Clear all button',excludeSemantics: true, child: IconButton(key: const Key('Clear'), iconSize: 48, onPressed: () => _clear(context), icon: const Icon(Icons.clear))),
              Semantics(label: 'Undo button',excludeSemantics: true, child: IconButton(key: const Key('Undo'), iconSize: 48, onPressed: () => _undo(context), icon: const Icon(Icons.undo))),
              Semantics(label: 'Redo button',excludeSemantics: true, child: IconButton(key: const Key('Redo'), iconSize: 48, onPressed: () => _redo(context), icon: const Icon(Icons.redo))),
              Semantics(label: 'Back button',excludeSemantics: true, child: IconButton(key: const Key('Back'), iconSize: 48, onPressed: () => _popBack(context), icon: const Icon(Icons.arrow_back))),
        ]),
        drawer: Drawer(
          child: Palette(context, key: const Key('Palette')),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: DrawArea(width: width, height: height),
          ),
        ),
      ),
    );
  }
  
  void _clear(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).clear();
  }
  
  void _undo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).undo();
  }

  void _redo(BuildContext context) {
    Provider.of<DrawingProvider>(context, listen: false).redo();
  }
  
  _popBack(BuildContext context) {
    Navigator.pop(context);
  }

  
}