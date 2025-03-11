import 'dart:async';
import 'dart:math';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

//player state = ung mga state ng sprite like walking, flying, etc.
class Zombie extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<Lugar>,
        HasGameReference<BarilGame> {
  Zombie({required this.pd, required this.direction})
    : super(size: Vector2.all(150), anchor: Anchor.center, priority: 1);
  late Playerdata pd;
  bool isAttacking = false;
  late Timer attackTimer;
  bool isDead = false;
  int health = 2;
  String direction;
  int speed = 0;
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad

    if (direction == "left") {
      scale.x = 1;
      speed = (-1) * (Random().nextInt(10));
    } else {
      scale.x = -1;
      speed = Random().nextInt(10);
    }
    animations = {
      //running
      PlayerState.running: await game.loadSpriteAnimation(
        'zombie/zombie_run.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          textureSize: Vector2(24, 27),
          stepTime: 0.15,
        ),
      ),
      PlayerState.attacking: await game.loadSpriteAnimation(
        'zombie/zombie_atk.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          textureSize: Vector2(30, 29),
          stepTime: 0.15,
        ),
      ),
      PlayerState.dead: await game.loadSpriteAnimation(
        'zombie/zombie_dead.png',
        SpriteAnimationData.sequenced(
          amount: 11,
          textureSize: Vector2(33, 30),
          stepTime: 0.15,
        ),
      ),
    };
    current = PlayerState.running;

    add(CircleHitbox());
    attackTimer = Timer(
      1,
      onTick: () {
        pd.updateHealth();
      },
    );
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    //controls
    if (health == 0) {
      isDead = true;
    }
    if (isDead) {
      position.x += 0;
      current = PlayerState.dead;
      Future.delayed(Duration(milliseconds: (11 * 0.15 * 1000).toInt()), () {
        removeFromParent();
      });
    } else {
      if (isAttacking) {
        //attack
        current = PlayerState.attacking;
        // position.x = position.x;
        if (!attackTimer.isRunning()) {
          attackTimer.start();
        }

        attackTimer.update(dt);
      } else {
        attackTimer.stop();
        position.x -= speed;
      }
    }

    if (position.x < (-game.size.x) || position.x > game.size.x) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // TODO: implement onCollision
    super.onCollisionStart(intersectionPoints, other);

    if (!isDead) {
      if (other is Player) {
        current = PlayerState.attacking;
        isAttacking = true;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    if (!isDead) {
      if (other is Player) {
        current = PlayerState.attacking;
        isAttacking = true;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);

    current = PlayerState.running;
    isAttacking = false;
  }
}

enum PlayerState { running, attacking, dead }
