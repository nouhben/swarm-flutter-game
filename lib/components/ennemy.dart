import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:xania/game_controller.dart';

class Enemy {
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  GameController gameController;
  bool isDead = false;

  Enemy(this.gameController, double x, double y) {
    health = 3;
    damage = 1;
    speed = gameController.tileSize * 2;
    enemyRect = Rect.fromLTWH(
      x,
      y,
      gameController.tileSize * 1.2,
      gameController.tileSize * 1.2,
    );
  }

  void render(Canvas canvas) {
    Color color;
    switch (health) {
      case 1:
        color = Color(0xffFF7F7F);
        break;
      case 2:
        color = Color(0xffFF4C4C);
        break;
      case 3:
        color = Color(0xffFF4500);
        break;
      default:
        color = Color(0xffFF0000);
        break;
    }
    Paint enemyColor = Paint()..color = color;
    canvas.drawRect(enemyRect, enemyColor);
  }

  void update(double t) {
    if (!isDead) {
      //distance separating the enemy from the player
      double stepDistance = speed * t;
      Offset toPlayer =
          gameController.player.playerRect.center - enemyRect.center;
      //we need to let the ennemy moves towards the player's position
      if (stepDistance <= toPlayer.distance) {
        Offset stepToPlayer =
            Offset.fromDirection(toPlayer.direction, stepDistance);
        //moves the enmy towards the specified postion
        enemyRect.shift(stepToPlayer);
      }
    }
  }

  void onTapDown(TapDownDetails details) {
    if (!isDead) {
      health--;
      if (health <= 0) {
        isDead = true;
        health = 3;
        //update the score
      }
    }
  }
}
