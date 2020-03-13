import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:xania/game_controller.dart';

class Enemy {
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  final GameController gameController;
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
      //the distance the enemy walks in a frame
      double stepDistance = speed * t;
      //distance separating the enemy from the player or our player's position
      Offset toPlayer =
          gameController.player.playerRect.center - enemyRect.center;
      //we need to let the enemy moves towards the player's position
      //no matter where he is
      // the -gameController.tileSize * 1.25 is used to leave some space
      //between the player end the enemy
      if (stepDistance <= toPlayer.distance - gameController.tileSize * 1.25) {
        Offset stepToPlayer =
            Offset.fromDirection(toPlayer.direction, stepDistance);
        //moves the enemy towards the specified position
        enemyRect.shift(stepToPlayer);
      } else {
        //the enemy is in the range to attack the player
        attack();
      }
    }
  }

  void attack() {
    if (!gameController.player.isDead) {
      gameController.player.currentHealth -= damage;
    }
  }

  void onTapDown() {
    if (!isDead) {
      health--;
      if (health <= 0) {
        isDead = true;
        //update the score
      }
    }
  }
}
