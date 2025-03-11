import 'dart:async';
import 'dart:ui';

import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';

class Background extends ParallaxComponent with HasWorldReference<Lugar> {
  Background({required this.player});

  Player player;

  @override
  Future<void> onLoad() async {
    final layers = [
      ParallaxImageData('scenery/background.png'),
      ParallaxImageData('scenery/clouds.png'),
      ParallaxImageData('scenery/cliffs.png'),
      ParallaxImageData('scenery/trees.png'),
      ParallaxImageData('scenery/ground.png'),
    ];

    final velocityMultiplierDelta = Vector2(2, 0.0);

    parallax = await Parallax.load(
      layers,
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
      repeat: ImageRepeat.repeatX,
    );
    priority = -1;
    position = Vector2(0, -350);
  }

  @override
  void update(double dt) {
    print("POSITION OF BG ${position}");
    super.update(dt);
    // Move background based on player's movement
    // if (player.isMoving) {
    //   if (player.direction == 'left') {
    //     parallax?.baseVelocity.x = player.player_speed.x;
    //   } else {
    //     parallax?.baseVelocity.x = -player.player_speed.x;
    //   }
    // } else {
    //   parallax?.baseVelocity.x = 0;
    // }
  }
}
