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
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Pinaka mataas na puntos: ${widget.pd.highscore}',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          minimumSize: Size(200, 50),
                        ),
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
                        child: Text(
                          "Simulan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<Playerdata>(
                            context,
                            listen: false,
                          ).pauseAudio();
                        },
                        child: Icon(
                          Provider.of<Playerdata>(
                                context,
                                listen: true,
                              ).bgMusic.playing
                              ? Icons.music_note
                              : Icons.music_off,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
