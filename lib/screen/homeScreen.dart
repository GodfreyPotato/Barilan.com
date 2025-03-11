import 'package:barilan/flame_game/gameScreen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer bgMusic;
  @override
  void initState() {
    super.initState();
    bgMusic = AudioPlayer();
    bgMusic.setAsset('assets/musics/backgroundmusic.mp3');

    bgMusic.playingStream.listen((data) {
      print('playing value $data');
      setState(() {});
    });
  }

  int score = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/cover.jpg', width: 400),
                Text(
                  'Pinaka mataas na iskor: $score',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Barilan . Com',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Text('Play Now'),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (bgMusic.playing) {
                          bgMusic.pause();
                        } else {
                          bgMusic.play();
                        }
                      },
                      child: Icon(
                        bgMusic.playing ? Icons.music_note : Icons.music_off,
                      ),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.settings),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
