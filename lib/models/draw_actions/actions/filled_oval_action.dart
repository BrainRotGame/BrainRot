import 'package:flutter/material.dart';

import '../draw_actions.dart';

// Class created to represent a filled drawing of an oval by the user
class OvalFilledAction extends DrawAction {
    // point on one corner of the oval when starting
  final Offset point1;
  // point on the opposite corner of the oval when ending
  final Offset point2;
  // color to be represented for when drawing the oval
  final Color color;

  // constructor to initialize values for the filled oval
  // Parameters:
    // point1: first starting corner point for the filled oval
    // point2: second point for opposite corner of filled oval
    // color: color of the oval
  OvalFilledAction(this.point1, this.point2, this.color);

  // method created in order to successfully paint the oval and filling it
  // with the paint when drawing
  // Parameters:
    // canvas: canvas the filled oval will be drawn on
    // paint: paint to design the filled oval
  void paint(Canvas canvas, Paint paint) {
    paint.color = color;
    paint.style  = PaintingStyle.fill;

    final boundRec = Rect.fromPoints(point1, point2);
    canvas.drawOval(boundRec, paint);
  }
}
