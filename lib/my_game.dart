
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_flame/my_map.dart';

import 'helpers/directions.dart';
import 'my_player.dart';

class MyGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection, HasKeyboardHandlerComponents {
  // MyPlayer myPlayer = MyPlayer();
  SpriteComponent background = SpriteComponent();
  final Vector2 viewportResolution;
  late MyPlayer myPlayer;

  MyGame({required this.viewportResolution})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: viewportResolution.x,
            height: viewportResolution.y,
          ),
        );

  static const String description = '''
    Move around with W, A, S, D and notice how the camera follows the ember 
    sprite.\n
    If you collide with the gray squares, the camera reference is changed from
    center to topCenter.\n
    The gray squares can also be clicked to show how the coordinate system
    respects the camera transformation.
  ''';

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Set World
    // background.sprite = await loadSprite('image_model.jpg');
    // background.size = size;

    // print("OnLoad $size");
    // await add(background);

    // // Set Player
    // await add(myPlayer);

    // camera.follow(
    //   myPlayer,
    //   snap: true,
    // );

    world.add(MyMap());
    world.add(myPlayer = MyPlayer());
    camera.setBounds(MyMap.bounds);
    camera.follow(myPlayer);

  }

  // @override
  // void onGameResize(Vector2 size) {
  //   super.onGameResize(size);
  //   background.size = size;
  //   print(size);
  // }

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

