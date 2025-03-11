import 'dart:async';

import 'package:barilan/flame_game/component/background.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/controls.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BarilGame extends FlameGame<Lugar> with HasCollisionDetection {
  BarilGame({required this.player})
    : super(
        //need para ma reference ung world to flamegame
        //dto manggagaling ang joystick
        world: Lugar(player: player),
        camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
      );

  Player player;
  @override
  FutureOr<void> onLoad() {
    camera.viewport.anchor = Anchor.center;
    //iaadd ung background
    camera.backdrop.add(Background(player: player));
    camera.viewport.add(LeftButton(player));
    camera.viewport.add(RightButton(player));
    camera.viewport.add(JumpButton(player));
    camera.viewport.add(FireButton(player));
    //add the player
    camera.viewfinder.add(player);
  }
}
