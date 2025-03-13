import 'dart:async';
import 'dart:math';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/world.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

//player state = ung mga state ng sprite like walking, flying, etc.
class Zombie2 extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<Lugar>,
        HasGameReference<BarilGame> {
  Zombie2({required this.pd, required this.direction})
    : super(size: Vector2.all(300), anchor: Anchor.center, priority: 1) {}

  late Playerdata pd;
  bool isAttacking = false;
  late Timer attackTimer;
  bool isDead = false;
  int health = 2;
  String direction;
  int speed = 0;
  bool dropBullet = false;
  bool SFX = true;
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    pd.manananggalWarningSFX();
    if (direction == "left") {
      scale.x = 1;
      speed = -50;
    } else {
      scale.x = -1;
      speed = 50;
    }
    animations = {
      //running
      PlayerState.running: await game.loadSpriteAnimation(
        'zombie2/Run.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          textureSize: Vector2(96, 96),
          stepTime: 0.15,
        ),
      ),
      PlayerState.attacking: await game.loadSpriteAnimation(
        'zombie2/Attack.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(96, 96),
          stepTime: 0.15,
        ),
      ),
      PlayerState.dead: await game.loadSpriteAnimation(
        'zombie2/Dead.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          textureSize: Vector2(96, 96),
          stepTime: 0.15,
        ),
      ),
    };

    current = PlayerState.running;

    add(CircleHitbox());
    attackTimer = Timer(
      1,
      onTick: () {
        pd.updateSuperMonster();
      },
    );
  }

  @override
  void onRemove() async {
    // TODO: implement onRemove
    attackTimer.stop();

    super.onRemove();
  }

  //if zombie dies, play this once
  void addBullet() {
    if (!dropBullet) {
      pd.updateBullet();

      dropBullet = true;
    }
  }

  void playSFX() async {
    if (SFX) {
      pd.death2SFX();
      SFX = false;
    }
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    //controls
    if (health <= 0) {
      isDead = true;
      playSFX();
    }
    if (isDead) {
      current = PlayerState.dead;
      Future.delayed(Duration(milliseconds: (11 * 0.15 * 1000).toInt()), () {
        addBullet();
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

    if ((position.x <= 0 && direction == "right") ||
        (position.x > world.size.x && direction == "left")) {
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
