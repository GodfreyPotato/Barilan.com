import 'package:barilan/flame_game/world.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class Barrier extends SpriteComponent
    with CollisionCallbacks, HasWorldReference<Lugar> {
  Barrier() : super();

  @override
  Future<void> onLoad() async {
    position = Vector2(world.size.x, 0);
    sprite = await Sprite.load('buttons/Jump.png');
    add(RectangleHitbox());
  }
}
