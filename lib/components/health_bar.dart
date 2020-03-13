import 'dart:ui';

import 'package:xania/game_controller.dart';

class HealthBar {
  final GameController gameController;
  Rect healthBarRect;
  Rect remainingHealthBarRect;

  HealthBar(this.gameController) {
    double barWidth = gameController.screenSize.width / 1.75;
    healthBarRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.8,
      barWidth,
      gameController.tileSize * 0.5,
    );
    remainingHealthBarRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.8,
      barWidth,
      gameController.tileSize * 0.5,
    );
  }

  void render(Canvas c) {
    Paint hbColor = Paint()..color = Color(0xffFF0000);
    Paint remHbColor = Paint()..color = Color(0xff00FF00);

    c.drawRect(healthBarRect, hbColor);
    c.drawRect(remainingHealthBarRect, remHbColor);
  }

  void update(double t) {
    double barWidth = gameController.screenSize.width / 1.75;
    double percentHealth =
        gameController.player.currentHealth / gameController.player.maxHealth;
    remainingHealthBarRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - barWidth / 2,
      gameController.screenSize.height * 0.8,
      barWidth * percentHealth,
      gameController.tileSize * 0.5,
    );
  }
}
