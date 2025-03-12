import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/world.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Barrier extends SpriteComponent
    with CollisionCallbacks, HasWorldReference<Lugar> {
  Barrier({required this.pos}) : super(size: Vector2.all(750), position: pos);
  Vector2 pos;
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('barrier/block.png');
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
    if (other is Player) {
      //sfx na warning
      other.inBarrier = true;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      //sfx na warning
      other.inBarrier = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
    if (other is Player) {
      other.inBarrier = false;
    }
  }
}
