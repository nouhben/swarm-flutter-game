import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xania/components/enemy.dart';
import 'package:xania/components/health_bar.dart';
import 'package:xania/components/highscore_text.dart';
import 'package:xania/components/score_text.dart';
import 'package:xania/components/start_button.dart';
import 'package:xania/enemy_spawner.dart';
import 'package:xania/state.dart';

import 'components/player.dart';

class GameController extends Game {
  final SharedPreferences storage;
  Size screenSize;
  double tileSize;
  Player player;
  EnemySpawner spawner;
  List<Enemy> enemies;
  HealthBar healthBar;
  Random rand;
  int score;
  ScoreText scoreText;
  HighscoreText highscoreText;
  GameState gameState;
  StartButton startButton;

  GameController(this.storage) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    rand = Random();
    gameState = GameState.menu;
    player = Player(this);
    enemies = List<Enemy>();
    spawner = EnemySpawner(this);
    healthBar = HealthBar(this);
    scoreText = ScoreText(this);
    highscoreText = HighscoreText(this);
    startButton = StartButton(this);
    score = 0;
  }

  void render(Canvas canvas) {
    Rect backgroundRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xffFAFAFA);
    canvas.drawRect(backgroundRect, backgroundPaint);

    player.render(canvas);
    if (gameState == GameState.menu) {
      startButton.render(canvas);
      highscoreText.render(canvas);
    } else if (gameState == GameState.playing) {
      enemies.forEach((Enemy enemy) => enemy.render(canvas));
      scoreText.render(canvas);
      healthBar.render(canvas);
    }
  }

  void update(double t) {
    if (gameState == GameState.menu) {
      //do start button update
      startButton.update(t);
      //high score text .update
      highscoreText.update(t);
    } else if (gameState == GameState.playing) {
      spawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t)); //async
      //enemies.removeWhere((Enemy enemy) => enemy.isDead);
      enemies.removeWhere((Enemy e) => e.isDead); //async
      player.update(t);
      scoreText.update(t);
      healthBar.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    if (gameState == GameState.menu) {
      gameState = GameState.playing;
    } else if (gameState == GameState.playing) {
      //check for each enemy if we tap on it
      //to decrease its health
      enemies.forEach((Enemy enemy) {
        if (enemy.enemyRect.contains(d.globalPosition)) {
          enemy.onTapDown();
        }
      });
    }
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
