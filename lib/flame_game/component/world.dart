import 'dart:math';
import 'dart:async';
import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/barrier.dart';
import 'package:barilan/flame_game/component/zombie.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/zombie2.dart';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

class Lugar extends World with HasGameReference<BarilGame> {
  Lugar({required this.player}) {
    _size = Vector2(10000, 720); // Default world size
  }

  late Player player;
  late Vector2 _size;
  bool superMonster = false;
  Vector2 get size => _size;

  /// Setter to update world size dynamically
  set size(Vector2 newSize) {
    _size = newSize;
  }

  /// Where the ground is located in the world and things should stop falling.
  late double groundLevel = (size.y / 2) - (size.y / 5);

  //runs every time called
  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
    game.overlays.add('backBut');
  }

  //run once
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad

    add(Barrier(pos: Vector2(size.x, -120)));
    add(Barrier(pos: Vector2(0 - 750, -120)));
    player.x = size.x / 2;
    add(player);
    //spawns

    add(
      SpawnComponent(
        area: Rectangle.fromPoints(
          Vector2(Random().nextDouble() * size.x, groundLevel - 80),
          Vector2(Random().nextDouble() * size.x, groundLevel - 80),
        ),
        factory: (_) => Zombie(pd: player.pd, direction: "right"),
        period: 5,
      ),
    );
    add(
      SpawnComponent(
        area: Rectangle.fromPoints(
          Vector2(Random().nextDouble() * size.x, groundLevel - 80),
          Vector2(Random().nextDouble() * size.x, groundLevel - 80),
        ),
        factory: (_) => Zombie(pd: player.pd, direction: "left"),
        period: 5,
      ),
    );
  }

  void addMonster() {
    if (!superMonster) {
      game.overlays.add("warning");
      Future.delayed(Duration(seconds: 3), () {
        game.overlays.remove("warning");
      });
      player.pd.warningSFX();
      add(
        SpawnComponent(
          area: Rectangle.fromPoints(
            Vector2(size.x, groundLevel - 80),
            Vector2(size.x, groundLevel - 80),
          ),
          factory: (_) => Zombie2(pd: player.pd, direction: "right"),
          period: 15,
        ),
      );
      add(
        SpawnComponent(
          area: Rectangle.fromPoints(
            Vector2(0, groundLevel - 80),
            Vector2(0, groundLevel - 80),
          ),
          factory: (_) => Zombie2(pd: player.pd, direction: "left"),
          period: 20,
        ),
      );
      superMonster = true;
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if (player.pd.currentScore >= 15) {
      addMonster();
    }
  }
}
