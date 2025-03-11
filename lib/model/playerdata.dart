import 'package:flutter/foundation.dart';

class Playerdata extends ChangeNotifier {
  int health = 20;

  void updateHealth() {
    health--;
    notifyListeners();
  }

  void reset() {
    health = 20;
    notifyListeners();
  }
}
