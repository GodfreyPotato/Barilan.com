import 'dart:async';

import 'package:barilan/flame_game/barilGame.dart';
import 'package:barilan/flame_game/component/bullet.dart';
import 'package:barilan/flame_game/effects/jump_effect.dart';
import 'package:barilan/flame_game/world.dart';
import 'package:barilan/model/playerdata.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

//player state = ung mga state ng sprite like walking, flying, etc.
class Player extends SpriteAnimationGroupComponent<PlayerState>
    with
        CollisionCallbacks,
        HasWorldReference<Lugar>,
        HasGameReference<BarilGame> {
  Player({required this.pd})
    : super(size: Vector2(100, 150), anchor: Anchor.center, priority: 1);
  late Playerdata pd;
  Vector2 player_speed = Vector2(10, 0);
  Vector2 _lastPosition = Vector2.zero();
  bool get inAir => (position.y + size.y / 2) < world.groundLevel;
  bool get isFalling => _lastPosition.y < position.y;
  double _gravityVelocity = 10;
  bool isMoving = false;
  String direction = "";
  bool isFiring = false;
  late Timer fireToIdle;

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    scale.x = -1;
    animations = {
      //running
      PlayerState.running: await game.loadSpriteAnimation(
        'cardo/run_21x28.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          textureSize: Vector2(21, 28),
          stepTime: 0.15,
        ),
      ),
      PlayerState.idle: await game.loadSpriteAnimation(
        'cardo/idle_13x29.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(13, 29),
          stepTime: 0.15,
        ),
      ),
      PlayerState.jumping: await game.loadSpriteAnimation(
        'cardo/jump_17x29.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2(17, 29),
          stepTime: 0.15,
        ),
      ),
      PlayerState.firing: await game.loadSpriteAnimation(
        'cardo/fire_19x29.png',
        SpriteAnimationData.sequenced(
          amount: 2,
          textureSize: Vector2(19, 29),
          stepTime: 0.15,
        ),
      ),
      PlayerState.falling: await game.loadSpriteAnimation(
        'cardo/fall.png',
        SpriteAnimationData.sequenced(
          amount: 1,
          textureSize: Vector2(17, 29),
          stepTime: 0.15,
        ),
      ),
      PlayerState.runfiring: await game.loadSpriteAnimation(
        'cardo/run_fire_22x29.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          textureSize: Vector2(22, 29),
          stepTime: 0.15,
        ),
      ),
    };

    fireToIdle = Timer(
      1,
      onTick: () {
        isFiring = false;
      },
      autoStart: false,
    );

    current = PlayerState.idle;
    _lastPosition.setFrom(position);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    fireToIdle.update(dt);
    //dead
    if (pd.health <= 0) {
      removeFromParent();
      game.overlays.add('gameOver');
    }
    //pag nag jump
    if (inAir) {
      current = isFalling ? PlayerState.falling : PlayerState.jumping;
      _gravityVelocity += dt;
      position.y += _gravityVelocity;

      if (isMoving) {
        position.x += direction == 'left' ? player_speed.x : -player_speed.x;
      } else {
        direction = "";
      }
    } else {
      if (isFiring) {
        current = isMoving ? PlayerState.runfiring : PlayerState.firing;
        position.x +=
            isMoving
                ? (direction == 'left' ? player_speed.x : -player_speed.x)
                : 0;
      } else {
        current = isMoving ? PlayerState.running : PlayerState.idle;
        position.x +=
            isMoving
                ? (direction == 'left' ? player_speed.x : -player_speed.x)
                : 0;
      }

      if (!isMoving) {
        direction = "";
      }
    }
  }

  void jump() {
    isFiring = false;
    if (!inAir) {
      current = PlayerState.jumping; // Set state

      // Set jump movement based on direction
      Vector2 jumpOffset;
      if (direction == 'left') {
        jumpOffset = Vector2(-50, -500); // Move up & slightly left
      } else if (direction == 'right') {
        jumpOffset = Vector2(50, -500); // Move up & slightly right
      } else {
        jumpOffset = Vector2(0, -500); // Just move up
      }

      // Apply Jump Effect
      final jumpEffect = JumpEffect(jumpOffset);

      add(jumpEffect);
    }
  }

  void fire() async {
    if (!inAir) {
      isFiring = true;
      position.x = position.x;
      var bullet = Bullet(
        direction: scale.x == -1 ? 'right' : 'left',
        pos: Vector2(position.x, position.y - 20),
      );

      world.add(bullet);
      fireToIdle.start();
    }
  }

  void startRun(String direction) {
    isFiring = false;
    if (direction == 'left') {
      scale.x = 1;
    } else {
      scale.x = -1;
    }
    this.direction = direction;
    isMoving = true;
  }

  void stopRun() {
    isMoving = false;
    isFiring = false;
  }
}

enum PlayerState { running, idle, jumping, falling, firing, runfiring }
