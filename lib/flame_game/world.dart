import 'dart:math';
import 'dart:async';
import 'package:barilan/flame_game/component/zombie.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

class Lugar extends World with HasGameReference {
  Lugar({required this.player}) {
    _random = Random();
  }

  late Player player;

  final double gravity = 0;

  Vector2 get size => (parent as FlameGame).size;

  /// Where the ground is located in the world and things should stop falling.
  late final double groundLevel = (size.y / 2) - (size.y / 5);

  late Random _random;

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

    add(player);
    //spawns
    // add(
    //   SpawnComponent(
    //     area: Rectangle.fromPoints(
    //       Vector2(size.x - 20, groundLevel - 80),
    //       Vector2(size.x - 20, groundLevel - 80),
    //     ),
    //     factory: (_) => Zombie(pd: player.pd, direction: "right"),
    //     period: 5,
    //   ),
    // );
    // add(
    //   SpawnComponent(
    //     area: Rectangle.fromPoints(
    //       Vector2(-size.x + 20, groundLevel - 80),
    //       Vector2(-size.x + 20, groundLevel - 80),
    //     ),
    //     factory: (_) => Zombie(pd: player.pd, direction: "left"),
    //     period: 2,
    //   ),
    // );
  }

  @override
  set debugMode(bool _debugMode) {
    // TODO: implement debugMode
    super.debugMode = true;
  }
}
