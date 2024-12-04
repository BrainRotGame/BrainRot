import 'package:brainrot/models/draw_actions/draw_actions.dart';
import 'package:brainrot/models/tools.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawing_painter.dart';

//Object represents a drawing area
//Object will read tap/mouse inputs, and display the drawing the user's creating
class DrawArea extends StatelessWidget {
  const DrawArea({super.key, required this.width, required this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) {
        return CustomPaint(
          size: Size(width, height),
          painter: DrawingPainter(drawingProvider),
          child: GestureDetector(
              onPanStart: (details) => _panStart(details, drawingProvider),
              onPanUpdate: (details) => _panUpdate(details, drawingProvider),
              onPanEnd: (details) => _panEnd(details, drawingProvider),
              child: Container(
                  width: width,
                  height: height,
                  color: Colors.transparent,
                  child: unchangingChild)),
        );
      },
    );
  }

  //Method will instantiate the beginning of a drawing of a particular tool whenever the user begins to click on the canvas
  //@param: takes in a details containing pointer information, and a drawingProvider to update
  void _panStart(DragStartDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools.line:
        drawingProvider.pendingAction = LineAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      case Tools.oval:
        drawingProvider.pendingAction = OvalAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      case Tools.filledOval:
        drawingProvider.pendingAction = OvalFilledAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
      case Tools.stroke:
        drawingProvider.pendingAction = StrokeAction(
          [details.localPosition],
          drawingProvider.colorSelected,
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }


  //Method will update the drawing state of a particular tool as the user continuous to draw (still holding down the pointer)
  //@param: takes in a details containing pointer information, and a drawingProvider to update
  void _panUpdate(DragUpdateDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        break;
      case Tools.line:
        final pendingAction = drawingProvider.pendingAction as LineAction;
        drawingProvider.pendingAction = LineAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools.oval:
        final pendingAction = drawingProvider.pendingAction as OvalAction;
        drawingProvider.pendingAction = OvalAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools.filledOval:
        final pendingAction = drawingProvider.pendingAction as OvalFilledAction;
        drawingProvider.pendingAction = OvalFilledAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools.stroke:
        final pendingAction = drawingProvider.pendingAction as StrokeAction;
        drawingProvider.pendingAction = StrokeAction(
          [...pendingAction.points, details.localPosition],
          pendingAction.color,
        );
        break;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  //Method will complete the drawing state of a particular tool as the user finishes their drawing action (no longer holding down on the pointer)
  //@param: takes in a details containing pointer information, and a drawingProvider to update
  void _panEnd(DragEndDetails details, DrawingProvider drawingProvider) {
    final finished = drawingProvider.pendingAction;

    drawingProvider.add(finished);
    drawingProvider.pendingAction = NullAction();
  }
}
