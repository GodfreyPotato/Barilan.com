import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Playerdata extends ChangeNotifier {
  int health = 5;
  int bullet = 10;
  late SharedPreferences prefs;
  int currentScore = 0;
  int highscore = 0;
  AudioPlayer bgMusic = AudioPlayer();
  late ConcatenatingAudioSource playList;

  Playerdata() {
    getHighScore();

    playList = ConcatenatingAudioSource(
      children: [
        AudioSource.asset("assets/musics/backgroundmusic.mp3"),
        AudioSource.asset("assets/musics/backgroundmusic.mp3"),
      ],
    );
    bgMusic.setAudioSource(playList);
    bgMusic.play();
  }

  void pauseAudio() {
    if (bgMusic.playing) {
      bgMusic.pause();
    } else {
      bgMusic.play();
    }
    notifyListeners();
  }

  void warningSFX() async {
    AudioPlayer warning = AudioPlayer();
    await warning.setAsset("assets/audio/warning.mp3");
    await warning.play();
    warning.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        warning.stop();
      }
    });
  }

  void gunshotSFX() async {
    AudioPlayer gunshot = AudioPlayer();
    gunshot.setVolume(.7);
    await gunshot.setAsset("assets/audio/gunshot.mp3");
    await gunshot.play();
    gunshot.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        gunshot.stop();
      }
    });
  }

  void addHealthtSFX() async {
    AudioPlayer addHealth = AudioPlayer();
    await addHealth.setAsset("assets/audio/addhealth.mp3");
    await addHealth.play();
    addHealth.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        addHealth.stop();
      }
    });
  }

  void death1tSFX() async {
    AudioPlayer death1 = AudioPlayer();
    List<String> deathsfx = ["death1", "death2", "death3"];
    await death1.setAsset(
      "assets/audio/${deathsfx[Random().nextInt(deathsfx.length)]}.mp3",
    );
    await death1.play();
    death1.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        death1.stop();
      }
    });
  }

  void death2SFX() async {
    AudioPlayer death2 = AudioPlayer();
    await death2.setAsset("assets/audio/death4.mp3");
    await death2.play();
    death2.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        death2.stop();
      }
    });
  }

  void manananggalWarningSFX() async {
    AudioPlayer manananggalWarning = AudioPlayer();
    await manananggalWarning.setAsset("assets/audio/manananggalWarning.mp3");
    await manananggalWarning.play();
    manananggalWarning.processingStateStream.listen((data) {
      if (data == ProcessingState.completed) {
        manananggalWarning.stop();
      }
    });
  }

  Future<void> getHighScore() async {
    prefs = await SharedPreferences.getInstance();
    highscore = prefs.getInt("highscore") ?? 0;
  }

  void updateHealth() {
    health--;
    notifyListeners();
  }

  void updateSuperMonster() {
    health -= 4;
    notifyListeners();
  }

  void reset() async {
    health = 5;
    bullet = 10;
    currentScore = 0;
    await getHighScore();
    notifyListeners();
  }

  void updateBullet() async {
    bullet += 3;
    currentScore += 1;
    if (Random().nextInt(100) < 10) {
      addHealthtSFX();
      health += 1;
    }

    if (currentScore > highscore) {
      await prefs.setInt("highscore", currentScore);
    }
    notifyListeners();
  }

  void fireBullet() {
    bullet -= 1;
    notifyListeners();
  }
}
