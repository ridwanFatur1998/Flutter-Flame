import 'dart:ffi';

import 'package:flame/components.dart' hide Timer;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:my_first_flame/core/tetris_main.dart';

class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
  TetrisMain _tetris = TetrisMain();

  final List<RectangleComponent> _wallComponentList = [];
  final List<RectangleComponent> _rectComponentList = [];
  final List<RectangleComponent> _nextMinoComponentList = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await draw();

    _tetris.setRenderCallback(renderCallback);
    // _tetris.setChangeMinoCallback(minoBottomHitCallback);
  }

  Future<void> draw() async {
    // for (var y = 0; y < _tetris.displayBuffer.length; y++) {
    //   final row = _tetris.displayBuffer[y];
    //   for (var x = 0; x < row.length; x++) {
    //     if (row[x] == 1) {
    //       _wallComponentList
    //           .add(createBlock(x + 1, y + 1, getBlockPaint(row[x])));
    //     } else if (row[x] > 1) {
    //       _rectComponentList
    //           .add(createBlock(x + 1, y + 1, getBlockPaint(row[x])));
    //     }
    //   }
    // }

    // for (var wall in _wallComponentList) {
    //   add(wall);
    // }
    // for (var rect in _rectComponentList) {
    //   add(rect);
    // }

    // createNextMino();
    // for (var nextMino in _nextMinoComponentList) {
    //   add(nextMino);
    // }

    add(getRenderText('NEXT', 360.0, 30.0));
    add(getRenderText('LEVEL', 360.0, 180.0));
    add(getRenderText('1', 360.0, 220.0));
    add(getRenderText('SCORE', 360.0, 280.0));
    add(getRenderText('0', 360.0, 320.0));
    // camera.followVector2(Vector2(pushGame.state.width * oneBlockSize / 2, pushGame.state.height * oneBlockSize / 2));
  }

  renderCallback() {
    resetRenderMino();
    renderMino();
  }

  void resetRenderMino() {
    for (var rect in _rectComponentList) {
      remove(rect);
    }
    _rectComponentList.clear();
  }

  void renderMino() {
    // for (var y = 0; y < _tetris.displayBuffer.length; y++) {
    //   final row = _tetris.displayBuffer[y];
    //   for (var x = 0; x < row.length; x++) {
    //     if (row[x] > 1) {
    //       _rectComponentList
    //           .add(createBlock(x + 1, y + 1, getBlockPaint(row[x])));
    //     }
    //   }
    // }
    // for (var rect in _rectComponentList) {
    //   add(rect);
    // }
  }

  TextComponent getRenderText(String text, double x, double y) {
    const style = TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    final regular = TextPaint(style: style);

    return TextComponent(text: text, textRenderer: regular)
      // ..anchor = Anchor.topCenter
      ..x = x
      ..y = y;
  }
}
