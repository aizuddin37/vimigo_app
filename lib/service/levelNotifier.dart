import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/level.dart';

class LevelNotifier with ChangeNotifier {
  List<Level> _levelList = [];

  late Level _currentLevel;

  Level get currentLevel => _currentLevel;

  set leveList(List<Level> levelList) {
    _levelList = levelList;
    notifyListeners();
  }

  set currentLevel(Level level) {
    _currentLevel = level;
    notifyListeners();
  }
}
