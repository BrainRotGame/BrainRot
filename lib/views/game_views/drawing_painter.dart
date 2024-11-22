import 'package:brainrot/models/draw_actions/draw_actions.dart';
import 'package:brainrot/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:brainrot/models/drawing.dart';

//Object represents a DrawingPainter for a drawing app
//Object will paint a particular thing on a Canvas/area
class DrawingPainter extends CustomPainter {
  final Drawing _drawing;
  final DrawingProvider _provider;

  DrawingPainter(DrawingProvider provider) : _drawing = provider.drawing, _provider = provider;


  //Method will update the painting canvas whenver the user draws on it
  //@param: takes in a Canvas that's being drawed on and the size of the Canvas
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.clipRect(rect); // make sure we don't scribble outside the lines.

    final erasePaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawRect(rect, erasePaint);

    for (final action in _provider.drawing.drawActions){
      _paintAction(canvas, action, size);
    }
    _paintAction(canvas, _provider.pendingAction, size);

  }

  //Method will paint a particular drawing associated with the selected tool on the canvas whenever the user draws on it
  //@param: takes in a Canvas to draw on, the drawAction the user's doing, and the size of the canvas
  void _paintAction(Canvas canvas, DrawAction action, Size size){
    final Rect rect = Offset.zero & size;
    final erasePaint = Paint()..blendMode = BlendMode.clear;

    switch (action) {
        case NullAction _:
          break;
        case ClearAction _:
          canvas.drawRect(rect, erasePaint);
          break;
        case final LineAction lineAction:
          final paint = Paint()..color = lineAction.color
          ..strokeWidth = 2;
          canvas.drawLine(lineAction.point1, lineAction.point2, paint);
          break;
        case final OvalAction ovalAction:
          final paint = Paint()..color = ovalAction.color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
          canvas.drawOval(Rect.fromPoints(ovalAction.point1, ovalAction.point2), paint);
          break;
        case final StrokeAction strokeAction:
          final paint = Paint()..color = strokeAction.color
          ..strokeWidth = 2;
          
          for(int i = 0; i < strokeAction.points.length-1; i++) {
            canvas.drawLine(strokeAction.points[i], strokeAction.points[i+1], paint);
          }
          break;
        default:
          throw UnimplementedError('Action not implemented: $action'); 
      }
  }

  //Method will determine if the drawingState should be repainted
  //@param: takes in a previous drawingInstance to compare with the current instance
  //@return: returns whether the current drawing has changed or not
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate._drawing != _drawing;
  }
}
