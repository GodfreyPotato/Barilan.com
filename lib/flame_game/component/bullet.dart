import 'dart:async';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/zombie.dart';
import 'package:barilan/flame_game/component/zombie2.dart';
import 'package:barilan/flame_game/component/world.dart';
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

  late Vector2 startingPosition;
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad

    startingPosition = pos;
    sprite = await Sprite.load('cardo/gunshot.png');
    add(CircleHitbox());
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
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
    if ((startingPosition.x - position.x) <= -(game.size.x / 2) ||
        (position.x - startingPosition.x) <= -(game.size.x / 2)) {
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
    if (other is Zombie2) {
      other.health -= 1;
      removeFromParent();
    }
  }
}
