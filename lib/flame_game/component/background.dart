import 'dart:async';
import 'dart:ui';

import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/world.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/rendering.dart';

class Background extends ParallaxComponent with HasWorldReference<Lugar> {
  Background({required this.player, required this.rand});
  int rand;
  Player player;

  final layers = [
    [
      ParallaxImageData('scenery/scene1/Sky.png'),
      ParallaxImageData('scenery/scene1/buildings.png'),
      ParallaxImageData('scenery/scene1/wall2.png'),
      ParallaxImageData('scenery/scene1/wall1.png'),
      ParallaxImageData('scenery/scene1/boxes&container.png'),
      ParallaxImageData('scenery/scene1/wheels&hydrant.png'),
      ParallaxImageData('scenery/scene1/road&border.png'),
    ],
    [
      ParallaxImageData('scenery/scene2/background.png'),
      ParallaxImageData('scenery/scene2/clouds.png'),
      ParallaxImageData('scenery/scene2/cliffs.png'),
      ParallaxImageData('scenery/scene2/trees.png'),
      ParallaxImageData('scenery/scene2/ground.png'),
    ],
    [
      ParallaxImageData('scenery/scene3/Sky.png'),
      ParallaxImageData('scenery/scene3/back.png'),
      ParallaxImageData('scenery/scene3/houses3.png'),
      ParallaxImageData('scenery/scene3/houses1.png'),
      ParallaxImageData('scenery/scene3/minishop&callbox.png'),
      ParallaxImageData('scenery/scene3/road&lamps.png'),
    ],
    [
      ParallaxImageData('scenery/scene4/sky.png'),
      ParallaxImageData('scenery/scene4/houses3.png'),
      ParallaxImageData('scenery/scene4/houses2.png'),
      ParallaxImageData('scenery/scene4/houses1.png'),
      ParallaxImageData('scenery/scene4/road.png'),
      ParallaxImageData('scenery/scene4/crosswalk.png'),
    ],
    [
      ParallaxImageData('scenery/scene5/sky.png'),
      ParallaxImageData('scenery/scene5/houses.png'),
      ParallaxImageData('scenery/scene5/houses2.png'),
      ParallaxImageData('scenery/scene5/fountain&bush.png'),
      ParallaxImageData('scenery/scene5/houses1.png'),
      ParallaxImageData('scenery/scene5/road.png'),
    ],
  ];
  @override
  Future<void> onLoad() async {
    final velocityMultiplierDelta = Vector2(2, 0.0);

    parallax = await Parallax.load(
      layers[rand],
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
      repeat: ImageRepeat.repeatX,
    );
    priority = -1;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (player.isMoving && !player.isBitten) {
      // Parallax moves only if the player is NOT in a barrier
      if (!player.inBarrier) {
        if (!player.inAir) {
          if (player.direction == 'left') {
            parallax?.baseVelocity.x = player.player_speed.x - 5;
          } else {
            parallax?.baseVelocity.x = -player.player_speed.x + 5;
          }
        } else {
          parallax?.baseVelocity.x = 0;
        }
      } else {
        parallax?.baseVelocity.x = 0;
      }
    } else {
      parallax?.baseVelocity.x = 0;
    }
  }
}
