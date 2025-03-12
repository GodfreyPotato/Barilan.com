import 'dart:async';
import 'dart:math';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/player.dart';
import 'package:barilan/flame_game/component/world.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

//player state = ung mga state ng sprite like walking, flying, etc.
class Zombie extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<Lugar>,
        HasGameReference<BarilGame> {
  Zombie({required this.pd, required this.direction})
    : super(size: Vector2.all(150), anchor: Anchor.center, priority: 1) {
    FlameAudio.audioCache.loadAll(["death1.mp3", "death3.mp3", "death2.mp3"]);
  }

  List soundFX = ["death1.mp3", "death3.mp3", "death2.mp3"];
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

    if (direction == "left") {
      scale.x = 1;
      speed = (-1) * (Random().nextInt(10)) - 1;
    } else {
      scale.x = -1;
      speed = Random().nextInt(10) + 1;
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

  //if zombie dies, play this once
  void addBullet() {
    if (!dropBullet) {
      pd.updateBullet();
      dropBullet = true;
    }
  }

  void playSFX() async {
    if (SFX) {
      FlameAudio.play(soundFX[Random().nextInt(soundFX.length)]);
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
      position.x = position.x;
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
    print("Position of zombies ${position} vs game size ${game.size}");
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
