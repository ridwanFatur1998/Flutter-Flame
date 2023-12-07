import 'package:my_first_flame/helpers/navigation_keys.dart';

import 'my_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await DesktopWindow.setWindowSize(const Size(500,500));
  // await DesktopWindow.setMaxWindowSize(const Size(500,500));
  // await DesktopWindow.setMinWindowSize(const Size(500,500));

  final game = MyGame(viewportResolution: Vector2(500, 500));

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GameWidget(
                game: game,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: NavigationKeys(
                  onDirectionChanged: (direction) {
                    game.onArrowKeyChanged(direction);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
