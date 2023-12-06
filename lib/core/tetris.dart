import 'dart:math' as math;
import 'mino.dart';
import '../utility/config.dart';
import '../utility/mino_enum.dart';
import '../utility/deep_copy.dart';

class Tetris {
  List<List<int>> field =
      List.generate(fieldHeight, (i) => List.generate(fieldWidth, (i) => 0));
  late Mino mino;
  late Mino nextMino;
  late Function changeMinoCallbackHandler;

  Tetris(
      {minoType = 0, minoAngle = 0, minoX = 5, minoY = 0, bool random = true}) {
    initField();

    if (random) {
      mino = getRandomMino();
      nextMino = getRandomMino();
    } else {
      mino = factoryMino(minoType, minoAngle, minoX, minoY);
      nextMino = getRandomMino();
    }
  }

  Mino factoryMino(int type, int angle, int x, int y) {
    return Mino(
      type: type,
      angle: angle,
      x: x,
      y: y,
    );
  }

  initField() {
    for (int i = 0; i < fieldHeight; i++) {
      field[i][0] = field[i][fieldWidth - 1] = 1;
    }
    for (int i = 0; i < fieldWidth; i++) {
      field.last[i] = 1;
    }

    // debug
    // for (int i = 0; i < fieldHeight; i++) {
    //   String buffer = "";
    //   for (int j = 0; j < fieldWidth; j++) {
    //     buffer += "${field[i][j]} ";
    //   }
    //   print(buffer);
    // }
  }

  Mino getRandomMino() {
    var random = math.Random();
    return Mino(
        type: random.nextInt(100) % MinoType.Max.index,
        angle: random.nextInt(100) % MinoAngle.a_max.index);
  }

  List<dynamic> get displayBuffer {
    var tmpDisplayBuffer = deepCopy(field);

    for (int i = 0; i < minoHeight; i++) {
      for (int j = 0; j < minoWidth; j++) {
        tmpDisplayBuffer[mino.y + i][getLimitFieldX(mino.x, j)] |=
            minoShapes[mino.type]![mino.angle]![i * minoWidth + j];
      }
    }

    return tmpDisplayBuffer;
  }

  bool cycle() {
    return true;
  }

  int getLimitFieldX(int minoX, int j) {
    var fieldX = (minoX + j) <= 0 ? 0 : minoX + j;
    if ((minoX + j) >= fieldWidth - 1) fieldX = fieldWidth - 1;
    return fieldX;
  }
}
