import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:xania/components/ennemy.dart';

import 'components/player.dart';

class GameController extends Game {
  Size screenSize;
  double tileSize;
  Player player;
  Enemy enemy;
  GameController() {
    initialize();
  }
  void render(Canvas canvas) {
    Rect backgroundRect = Rect.fromLTWH(
      0,
      0,
      screenSize.width,
      screenSize.height,
    );
    Paint backgroundPaint = Paint()..color = Color(0xffFAFAFA);
    canvas.drawRect(backgroundRect, backgroundPaint);

    player.render(canvas);
    enemy.render(canvas);
  }

  void update(double t) {
    enemy.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    player = Player(this);
    enemy = Enemy(this, 100, 100);
  }

  void onTapDown(TapDownDetails details) {
    enemy.onTapDown(details);
  }
}
