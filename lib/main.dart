import 'package:flutter/material.dart';
import 'package:my_first_flame/main_game_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpriteAnime',
      home: MainGamePage(),
    );
  }
}