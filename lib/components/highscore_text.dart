import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xania/game_controller.dart';

class HighscoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  HighscoreText(this.gameController) {
    painter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    position = Offset.zero;
  }
  void render(Canvas c) {
    painter.paint(c, position);
  }

  //here to update the score
  void update(double t) {
    int highscore = gameController.storage.getInt('highscore') ?? 0;
    painter.text = TextSpan(
      text: 'Best: $highscore',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40.0),
    );
    painter.layout();
    position = Offset(
      gameController.screenSize.width / 2 - painter.width / 2,
      gameController.screenSize.height * 0.2 - painter.height / 2,
    );
  }
}
