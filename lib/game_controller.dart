import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:xania/components/enemy.dart';
import 'package:xania/components/health_bar.dart';

import 'components/player.dart';

class GameController extends Game {
  Size screenSize;
  double tileSize;
  Player player;
  List<Enemy> enemies;
  HealthBar healthBar;
  Random rand;
  GameController() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    healthBar = HealthBar(this);
  }

  void render(Canvas canvas) {
    Rect backgroundRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xffFAFAFA);
    canvas.drawRect(backgroundRect, backgroundPaint);

    player.render(canvas);
    enemies.forEach((Enemy enemy) => enemy.render(canvas));
    healthBar.render(canvas);
  }

  void update(double t) {
    enemies.forEach((Enemy enemy) => enemy.update(t));
    enemies.removeWhere((Enemy enemy) => enemy.isDead);
    player.update(t);
    healthBar.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    //check for each enemy if we tap on it
    //to decrease its health
    enemies.forEach((Enemy enemy) {
      if (enemy.enemyRect.contains(d.globalPosition)) {
        enemy.onTapDown();
      }
    });
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0:
        //Top screen or north
        //x will be anywhere on the top horizon
        x = rand.nextDouble() * screenSize.width;
        //y is up the roof lol
        y = -tileSize * 2.5;
        break;
      case 1:
        //right screen or west
        //x will be anywhere on the right side but outside of course
        x = screenSize.width + tileSize * 2.5;
        //y is up the roof lol
        y = screenSize.height * rand.nextDouble();
        break;
      case 2:
        //Bottom screen or south
        //x will be anywhere  the bottom edge
        x = rand.nextDouble() * screenSize.width;
        //y is up the roof lol
        y = screenSize.height + tileSize * 2.5;
        break;
      case 3:
        //left screen or east
        //x will be anywhere  the outside left edge
        x = -tileSize * 2.5;
        //y is up the roof lol
        y = screenSize.height * rand.nextDouble();
        break;
    }
    enemies.add(Enemy(this, x, y));
  }
}
