import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helpers/directions.dart';

class MyGame extends FlameGame with KeyboardEvents {
  MyPlayer myPlayer = MyPlayer();
  SpriteComponent background = SpriteComponent();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Set World
    background.sprite = await loadSprite('image_model.jpg');
    background.size = size;

    print("OnLoad $size");
    await add(background);


    // Set Player
    await add(myPlayer);

    camera.follow(
      myPlayer,
      snap: true,
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background.size = size;
    print(size);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      myPlayer.direction = keyDirection;
    } else if (myPlayer.direction == keyDirection) {
      myPlayer.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void onArrowKeyChanged(Direction direction) {
    myPlayer.direction = direction;
  }
}

class MyPlayer extends RectangleComponent {
  Direction direction = Direction.none;

  MyPlayer()
      : super(
          size: Vector2.all(40),
          position: Vector2(0, 0),
          paint: BasicPalette.red.paint(),
        );

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y -= 10;
        break;
      case Direction.down:
        position.y += 10;
        break;
      case Direction.left:
        position.x -= 10;
        break;
      case Direction.right:
        position.x += 10;
        break;
      case Direction.none:
        break;
    }
  }
}
