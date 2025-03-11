import 'dart:async';

import 'package:barilan/flame_game/component/player.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class JumpButton extends HudButtonComponent {
  JumpButton(this.player, this.spr)
    : super(
        button: SpriteComponent(sprite: spr, size: Vector2.all(150)),
        margin: const EdgeInsets.only(bottom: 20, right: 400),
        // position: Vector2(120, 400), // Adjust for button placement
        onPressed: () {
          player.jump();
          print("Im clicked");
        },
      );
  final Sprite spr;
  final Player player;
}

class LeftButton extends HudButtonComponent {
  LeftButton(this.player, this.spr)
    : super(
        button: SpriteComponent(sprite: spr, size: Vector2.all(150)),
        margin: const EdgeInsets.only(bottom: 20, left: 100),
        // position: Vector2(120, 400), // Adjust for button placement
        onPressed: () => player.startRun('right'),
        onReleased: () => player.stopRun(),
        onCancelled: () => player.stopRun(),
      );
  final Sprite spr;
  final Player player;
}

class RightButton extends HudButtonComponent {
  RightButton(this.player, this.spr)
    : super(
        button: SpriteComponent(sprite: spr, size: Vector2.all(150)),
        margin: const EdgeInsets.only(bottom: 20, left: 300),
        // position: Vector2(120, 400), // Adjust for button placement
        onPressed: () => player.startRun('left'),
        onReleased: () => player.stopRun(),
        onCancelled: () => player.stopRun(),
      );
  final Sprite spr;
  final Player player;
}

class FireButton extends HudButtonComponent {
  FireButton(this.player, this.spr)
    : super(
        button: SpriteComponent(sprite: spr, size: Vector2.all(150)),
        margin: const EdgeInsets.only(bottom: 20, right: 200),
        // position: Vector2(120, 400), // Adjust for button placement
        onPressed: () => player.fire(),
      );
  final Sprite spr;
  final Player player;
}
