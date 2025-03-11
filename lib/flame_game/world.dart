import 'dart:math';
import 'dart:async';
import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/background.dart';
import 'package:barilan/flame_game/component/zombie.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

class Lugar extends World with HasGameReference<BarilGame> {
  Lugar({required this.player}) {
    _size = Vector2(3000, 720); // Default world size
  }

  late Player player;
  late Vector2 _size;

  Vector2 get size => _size;

  /// Setter to update world size dynamically
  set size(Vector2 newSize) {
    _size = newSize;
  }

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 5);

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
    add(Background(player: player));

    player.x = size.x / 2;
    add(player);
    //spawns
    add(
      SpawnComponent(
        area: Rectangle.fromPoints(
          Vector2(size.x - 20, groundLevel - 80),
          Vector2(size.x - 20, groundLevel - 80),
        ),
        factory: (_) => Zombie(pd: player.pd, direction: "right"),
        period: 3,
      ),
    );
    // add(
    //   SpawnComponent(
    //     area: Rectangle.fromPoints(
    //       Vector2(0, groundLevel - 80),
    //       Vector2(0, groundLevel - 80),
    //     ),
    //     factory: (_) => Zombie(pd: player.pd, direction: "left"),
    //     period: 2,
    //   ),
    // );
  }
}
