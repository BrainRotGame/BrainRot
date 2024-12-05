import 'package:brainrot/models/tools.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Palette object represents a widget in a DrawingApp
//Palette is a UI element containing a collection of colors and tools that the user can pick from to customize their drawing
class Palette extends StatelessWidget {
  const Palette(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Tools and Colors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          ),
          _buildToolButton(
            name: 'Line',
            icon: Icons.line_axis,
            tool: Tools.line,
            provider: drawingProvider,
          ),
          _buildToolButton(
            name: 'Stroke',
            icon: Icons.brush,
            tool: Tools.stroke,
            provider: drawingProvider,
          ),
          _buildToolButton(
            name: 'Oval',
            icon: Icons.circle_outlined,
            tool: Tools.oval,
            provider: drawingProvider,
          ),
          _buildToolButton(
            name: 'Filled Oval',
            icon: Icons.circle,
            tool: Tools.filledOval,
            provider: drawingProvider,
          ),

          // Add missing tools here
          const Divider(),
          _buildColorButton('Red', Colors.red, drawingProvider),
          _buildColorButton('Orange', Colors.orange, drawingProvider),
          _buildColorButton('Yellow', Colors.yellow, drawingProvider),
          _buildColorButton('Green', Colors.green, drawingProvider),
          _buildColorButton('Blue', Colors.blue, drawingProvider),
          _buildColorButton('Indigo', Colors.indigo, drawingProvider),
          _buildColorButton('Purple', Colors.purple, drawingProvider),
          _buildColorButton('Black', Colors.black, drawingProvider),
          _buildColorButton('Grey', Colors.grey, drawingProvider),
          _buildColorButton('White', Colors.white, drawingProvider),
          _buildColorButton('Brown', Colors.brown, drawingProvider),

        ],
      ),
    );
  }

  //Method will create a Toolbutton from a given name, icon, and tool
  //When clicked on, the app will choose its associated tool, or unselect it if it's already selected
  //@param: takes in a name, icon, and tool associated with the button, and a DrawingProvider to update
  //@return: returns a toolButton associated with a particular tool
  Widget _buildToolButton(
      {required String name,
      required IconData icon,
      required Tools tool,
      required DrawingProvider provider}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        key: Key(name),
        onTap: () {
          if(tool == provider.toolSelected) {
            provider.toolSelected = Tools.none;
          }
          else {
            provider.toolSelected = tool;
          }
        },
        child: Semantics(
          label: name,
          excludeSemantics: true,
          selected: provider.toolSelected == tool,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Icon(icon, color: provider.toolSelected == tool ? Colors.white : const Color.fromARGB(255, 101, 108, 112) , size: 48,)),
        )


      ),
    );
  }

  //Method will create a button of a particular color
  //When clicked on, the app will choose its associated color
  //@param: takes in a color and name, and a DrawingProvider to update
  //@return: returns a button associated with a particular color
  Widget _buildColorButton(String name, Color color, DrawingProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        key: Key(name),
        onTap: () {
          provider.colorSelected = color;
        },
        child: Semantics(
          label: name,
          excludeSemantics: true,
          selected: provider.colorSelected == color,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: provider.colorSelected == color ? color.withOpacity(0.1) : color,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

}
