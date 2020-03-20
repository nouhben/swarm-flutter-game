import 'dart:ui';

import 'package:xania/game_controller.dart';
import 'package:xania/state.dart';

class Player {
  int maxHealth;
  int currentHealth;
  Rect playerRect;
  bool isDead = false;
  final GameController gameController;

  Player(this.gameController) {
    maxHealth = currentHealth = 300;
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - size / 2,
      gameController.screenSize.height / 2 - size / 2,
      size,
      size,
    );
  }

  void render(Canvas canvas) {
    Paint playerColor = Paint()..color = Color(0xff0000FA);
    canvas.drawRect(playerRect, playerColor);
  }

  void update(double t) {
    if (!isDead && currentHealth <= 0) {
      isDead = true;
      gameController.gameState = GameState.menu;
    }
  }
}
