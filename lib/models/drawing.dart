import 'draw_actions/draw_actions.dart';

//Object represents a set of drawings in a drawing app
//Drawing has a width/height, and will track all drawing actions
class Drawing {
  final double width;
  final double height;

  final List<DrawAction> drawActions;

  Drawing(this.drawActions, {required this.width, required this.height});
}