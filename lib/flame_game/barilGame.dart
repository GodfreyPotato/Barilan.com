import 'dart:async';
import 'dart:math';

import 'package:barilan/flame_game/component/background.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/controls.dart';
import 'package:barilan/flame_game/component/world.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BarilGame extends FlameGame<Lugar> with HasCollisionDetection {
  BarilGame({required this.player, required this.rand})
    : super(
        //need para ma reference ung world to flamegame
        world: Lugar(player: player),
        camera: CameraComponent.withFixedResolution(
          width: 1600,
          height: 720,
          backdrop: Background(player: player, rand: rand),
        ),
      );
  int rand;
  late Sprite RightBut;
  late Sprite LeftBut;
  late Sprite JumpBut;
  late Sprite FireBut;
  Player player;
  @override
  FutureOr<void> onLoad() async {
    // await FlameAudio.audioCache.loadAll(["addhealth.mp3","death1.mp3","death2.mp3","death3.mp3","death4.mp3","gunshot.mp3","manananggalWarning.mp3","warning.mp3"]);
    if (rand == 0) {
    } else if (rand == 2) {
      world.groundLevel += 80;
    } else if (rand == 3) {
      world.groundLevel += 80;
    }

    player.y -= 400;
    RightBut = await Sprite.load('buttons/FB.png');
    LeftBut = await Sprite.load('buttons/BB.png');
    FireBut = await Sprite.load('buttons/Fire.png');
    JumpBut = await Sprite.load('buttons/Jump.png');
    camera.follow(player, horizontalOnly: true);
    camera.viewport.add(LeftButton(player, LeftBut));
    camera.viewport.add(RightButton(player, RightBut));
    camera.viewport.add(JumpButton(player, JumpBut));
    camera.viewport.add(FireButton(player, FireBut));
  }
}
