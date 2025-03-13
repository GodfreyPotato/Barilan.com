import 'dart:math';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/healthandbulet.dart';
import 'package:barilan/flame_game/component/player.dart';

import 'package:barilan/model/playerdata.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.pd});
  Playerdata pd;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    FlameAudio.audioCache.clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<BarilGame>(
        game: BarilGame(
          player: Player(pd: Provider.of<Playerdata>(context, listen: false)),
          rand: Random().nextInt(5),
        ),
        overlayBuilderMap: {
          'backBut':
              (context, game) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HealthAndBullet(),
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
              ),
          'gameOver':
              (context, game) => Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade500,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.black87),
                  ),
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/bg/warning.png",
                            height: 75,
                            width: 75,
                          ),
                          Text(
                            "Warning!",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Lalabas na ang manananggal!",
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 200,
                //   height: 200,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Image.asset("assets/bg/gameOver2.png"),
                //       Text(
                //         "Score: ${widget.pd.currentScore}",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w800,
                //         ),
                //       ),
                //       Row(
                //         spacing: 12,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           GestureDetector(
                //             onTap: () {
                //               Navigator.of(context).pop();
                //               Provider.of<Playerdata>(
                //                 context,
                //                 listen: false,
                //               ).reset();
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 0.0),
                //               child: Container(
                //                 alignment: Alignment.center,
                //                 width: 80,
                //                 height: 30,
                //                 decoration: BoxDecoration(
                //                   border: Border.all(
                //                     width: 1,
                //                     color: Colors.white60,
                //                   ),
                //                   color: Colors.deepPurple,
                //                   borderRadius: BorderRadius.circular(13),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(1.0),
                //                   child: Text(
                //                     "Home",
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.w700,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           GestureDetector(
                //             onTap: () {
                //               Navigator.of(context).pop();
                //               Navigator.of(context).push(
                //                 MaterialPageRoute(
                //                   builder:
                //                       (context) => GameScreen(
                //                         pd: Provider.of<Playerdata>(
                //                           context,
                //                           listen: false,
                //                         ),
                //                       ),
                //                 ),
                //               );
                //               Provider.of<Playerdata>(
                //                 context,
                //                 listen: false,
                //               ).reset();
                //             },
                //             child: Padding(
                //               padding: const EdgeInsets.only(bottom: 0.0),
                //               child: Container(
                //                 alignment: Alignment.center,
                //                 width: 80,
                //                 height: 30,
                //                 decoration: BoxDecoration(
                //                   border: Border.all(
                //                     width: 1,
                //                     color: Colors.white60,
                //                   ),
                //                   color: Colors.deepPurple,
                //                   borderRadius: BorderRadius.circular(13),
                //                 ),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(1.0),
                //                   child: Text(
                //                     "Try Again",
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.w700,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
              ),
          "warning":
              (context, game) => Center(
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.red,
                  child: Column(
                    children: [
                      Image.asset("assets/bg/warning.png"),
                      Text(
                        "Warning! Lalabas na ang manananggal!",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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
