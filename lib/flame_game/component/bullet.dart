import 'dart:async';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/zombie.dart';
import 'package:barilan/flame_game/effects/jump_effect.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

//player state = ung mga state ng sprite like walking, flying, etc.
class Bullet extends SpriteComponent
    with
        CollisionCallbacks,
        HasWorldReference<Lugar>,
        HasGameReference<BarilGame> {
  Bullet({required this.direction, required this.pos})
    : super(
        size: Vector2.all(20),
        position: pos,

        priority: 10,
        anchor: Anchor.center,
      );
  String direction;
  Vector2 pos;

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite = await Sprite.load('dash/gunshot.png');
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    if (direction == "left") {
      scale.x = 1;
      position.x += 20;
    } else if (direction == "right") {
      scale.x = -1;
      position.x -= 20;
    }
    if ((position.x <= 0) || (position.x >= world.size.x)) {
      print("$position gone");
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);

    if (other is Zombie) {
      other.health -= 1;
      removeFromParent();
    }
  }
}
