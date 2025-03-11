import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:barilan/flame_game/component/player.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class Background extends ParallaxComponent {
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

    // The base velocity sets the speed of the layer the farthest to the back.
    // Since the speed in our game is defined as the speed of the layer in the
    // front, where the player is, we have to calculate what speed the layer in
    // the back should have and then the parallax will take care of setting the
    // speeds for the rest of the layers.

    // The multiplier delta is used by the parallax to multiply the speed of
    // each layer compared to the last, starting from the back. Since we only
    // want our layers to move in the X-axis, we multiply by something larger
    // than 1.0 here so that the speed of each layer is higher the closer to the
    // screen it is.
    final velocityMultiplierDelta = Vector2(2, 0.0);

    parallax = await game.loadParallax(
      layers,
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move background based on player's movement
    if (player.isMoving) {
      if (player.direction == 'left') {
        parallax?.baseVelocity.x = player.player_speed.x;
      } else {
        parallax?.baseVelocity.x = -player.player_speed.x;
      }
    } else {
      parallax?.baseVelocity.x = 0;
    }
  }
}
