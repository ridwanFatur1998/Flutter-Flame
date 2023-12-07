
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import 'helpers/directions.dart';

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
