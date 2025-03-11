import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/health.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/main.dart';
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
              (context, game) => Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Provider.of<Playerdata>(context, listen: false).reset();
                    },
                    child: Icon(Icons.play_arrow),
                  ),
                  Health(),
                ],
              ),
          'gameOver':
              (context, game) => Container(
                width: 200,
                height: 200,
                color: Colors.red,
                child: Center(child: Column(children: [Text("Game Over")])),
              ),
        },
      ),
    );
  }
}
