import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/health.dart';
import 'package:barilan/flame_game/component/player.dart';

import 'package:barilan/model/playerdata.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<BarilGame>(
        game: BarilGame(
          player: Player(pd: Provider.of<Playerdata>(context, listen: false)),
        ),
        overlayBuilderMap: {
          'backBut':
              (context, game) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Score: 21312",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Health(),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Provider.of<Playerdata>(
                            context,
                            listen: false,
                          ).reset();
                        },
                        child: Icon(Icons.home),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.restart_alt),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.music_off),
                      ),
                    ],
                  ),
                ],
              ),
          'gameOver':
              (context, game) => Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  width: 200,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/bg/gameOver2.png"),
                      Text(
                        "Score: 12",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        spacing: 12,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white60,
                                ),
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  "Home",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white60,
                                ),
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        },
      ),
    );
  }
}
