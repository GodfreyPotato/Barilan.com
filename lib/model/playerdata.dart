import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Playerdata extends ChangeNotifier {
  int health = 20;
  int bullet = 10;
  late SharedPreferences prefs;
  int currentScore = 0;
  int highscore = 0;

  Playerdata() {
    getHighScore();
  }

  Future<void> getHighScore() async {
    prefs = await SharedPreferences.getInstance();
    highscore = prefs.getInt("highscore") ?? 0;
  }

  void updateHealth() {
    health--;
    notifyListeners();
  }

  void reset() async {
    health = 20;
    bullet = 10;
    currentScore = 0;
    await getHighScore();
    notifyListeners();
  }

  void updateBullet() async {
    bullet += 3;
    currentScore += 1;
    notifyListeners();
    if (currentScore > highscore) {
      await prefs.setInt("highscore", currentScore);
    }
  }

  void fireBullet() {
    bullet -= 1;
    notifyListeners();
  }
}
