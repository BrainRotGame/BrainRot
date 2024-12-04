import 'package:flutter/material.dart';

import '../models/draw_actions/draw_actions.dart';
import '../models/drawing.dart';
import '../models/tools.dart';

//Object is a Provider for a Drawing
//Object will track the drawing state and drawing tool, and notify listeners whenever a drawing change occurs
class DrawingProvider extends ChangeNotifier {
  Drawing?
      _drawing; // used to create a cached drawing via replay of past actions
  DrawAction _pendingAction = NullAction();
  Tools _toolSelected = Tools.none;
  Color _colorSelected = Colors.blue;

  final List<DrawAction> _pastActions;
  final List<DrawAction> _futureActions;

  final double width;
  final double height;

  DrawingProvider({required this.width, required this.height})
      : _pastActions = [],
        _futureActions = [];

  Drawing get drawing {
    if (_drawing == null) {
      _createCachedDrawing();
    }
    return _drawing!;
  }

  //Setter method sets DrawingProvider to a new drawing action then notifies the drawing app
  //@param: takes in a new action to set to whenever the user draws
  set pendingAction(DrawAction action) {
    _pendingAction = action;
    _invalidateAndNotify();
  }

  DrawAction get pendingAction => _pendingAction;

  //Setter method sets DrawingProvider to a newly selected tool
  //@param: takes in a new drawing tool to set to
  set toolSelected(Tools aTool) {
    _toolSelected = aTool;
    _invalidateAndNotify();
  }

  Tools get toolSelected => _toolSelected;

  //Setter method sets DrawingProvider to a newly selected color choice that the user chooses
  //@param: takes in a Color to set to
  set colorSelected(Color color) {
    _colorSelected = color;
    _invalidateAndNotify();
  }

  Color get colorSelected => _colorSelected;

  List<DrawAction> get pastActions => _pastActions;

  List<DrawAction> get futureActions => _futureActions;


  //Method will create a newly cached drawing from pastActions
  //If there exist no previous drawing actions, the Provider will create a brand new empty drawing
  //If there exists previous drawing actions, the Provider will create a new Drawing from all the past actions up to the latest clearAction (or all actions if there isn't a CLear)
  void _createCachedDrawing() {
    final int index = pastActions.lastIndexOf(ClearAction());
    if(index >= 0) {
      _drawing = Drawing(pastActions.sublist(index+1), width: width, height: height);
    }
    else {
       if(pastActions.isNotEmpty) {
        _drawing = Drawing(pastActions, width: width, height: height);
      }
      else {
        _drawing = Drawing([], width: width, height: height);
      }
    }
  }

  //This method will reset the drawing and notify all listeners
  void _invalidateAndNotify() {
    _drawing = null;
    notifyListeners();
  }

  //@param: takes in a DrawAction to add
  void add(DrawAction action) {
    if(action is! NullAction) {
      pastActions.add(action);
      // print(pastActions);
      // _drawing!.drawActions.add(action);
      futureActions.clear();
      _invalidateAndNotify();
    }

  }

  //Method will 'undo' a drawing action if there is an available drawing state to undo to
  void undo() {
    if (pastActions.isNotEmpty) {
      futureActions.add(pastActions[pastActions.length-1]);
      // _drawing!.drawActions.removeLast();
      pastActions.removeLast();
      _invalidateAndNotify();
    }
  }

  //Method will 'redo' a drawing action if there is a drawingAction to redo to
  void redo() {
    if(futureActions.isNotEmpty) {
      final DrawAction action = futureActions[futureActions.length-1];
      pastActions.add(action);
      // _drawing!.drawActions.add(action);
      futureActions.removeLast();
      _invalidateAndNotify();
    }
  }

  //Method will clear the drawing of all drawing actions
  //Clear action is capable of being undone
  void clear() {
    // print(pastActions);
    add(ClearAction());
    // print(pastActions);
  }

  //Method will completely wipe all drawing data from pastActions and futureActions
  void wipeDrawing() {
    _pastActions.removeRange(0, _pastActions.length);
    _futureActions.removeRange(0, _futureActions.length);
  }
}
