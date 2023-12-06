import 'dart:async';

import 'package:my_first_flame/core/tetris.dart';

import 'mino.dart';
import '../utility/mino_enum.dart';

class TetrisMain {
  late Tetris gameCore;
  late Timer gameLoop;
  late Function renderCallbackHandler;
  late Function bottomHitCallbackHandler;

  TetrisMain({
    int minoType = 0,
    int minoAngle = 0,
    int minoX = 5,
    int minoY = 0,
    bool random = true,
  }) {
    gameCore = Tetris(
      minoType: minoType,
      minoAngle: minoAngle,
      minoX: minoX,
      minoY: minoY,
      random: random,
    );
    gameLoop = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      loop();
    });
  }

// List<dynamic> get displayBuffer => gameCore.displayBuffer;

  void setRenderCallback(Function fn) => renderCallbackHandler = fn;

  void loop() {
    cycle();
  }

  void cycle() {
    renderCallbackHandler();

    if (!gameCore.cycle()) {
      gameLoop.cancel();
      gameCore.cycle();
      renderCallbackHandler();
    }
  }
}
