import 'package:barilan/flame_game/gameScreen.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.pd});
  Playerdata pd;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isLoaded = false;
  void loadEverything() async {
    await widget.pd.getHighScore();
    isLoaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadEverything();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          !isLoaded
              ? Center(child: CircularProgressIndicator())
              : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg/homebg.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Pinaka mataas na iskor: ${widget.pd.highscore}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => GameScreen(
                                    pd: Provider.of<Playerdata>(
                                      context,
                                      listen: false,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Text("Simulan"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (Provider.of<Playerdata>(
                            context,
                            listen: false,
                          ).bgMusic.playing) {
                            Provider.of<Playerdata>(
                              context,
                              listen: false,
                            ).bgMusic.pause();
                          } else {
                            Provider.of<Playerdata>(
                              context,
                              listen: false,
                            ).bgMusic.play();
                          }
                        },
                        child: Icon(
                          Provider.of<Playerdata>(
                                context,
                                listen: true,
                              ).bgMusic.playing
                              ? Icons.music_note
                              : Icons.music_off,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
