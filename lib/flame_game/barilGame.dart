import 'dart:async';

import 'package:barilan/flame_game/component/background.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/controls.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BarilGame extends FlameGame<Lugar> with HasCollisionDetection {
  BarilGame({required this.player})
    : super(
        //need para ma reference ung world to flamegame
        world: Lugar(player: player),
        camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
      );

  late Sprite RightBut;
  late Sprite LeftBut;
  late Sprite JumpBut;
  late Sprite FireBut;
  Player player;
  @override
  FutureOr<void> onLoad() async {
    RightBut = await Sprite.load('buttons/FB.png');
    LeftBut = await Sprite.load('buttons/BB.png');
    FireBut = await Sprite.load('buttons/Fire.png');
    JumpBut = await Sprite.load('buttons/Jump.png');
    camera.follow(player, horizontalOnly: true);
    camera.viewport.add(LeftButton(player, LeftBut));
    camera.viewport.add(RightButton(player, RightBut));
    camera.viewport.add(JumpButton(player, JumpBut));
    camera.viewport.add(FireButton(player, FireBut));
    //add the player
    // camera.backdrop.add(Background(player: player));

    // player.x = world.size.x / 2;
    // world.add(player);
  }
}
