import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xania/game_controller.dart';

class ScoreText {
  final GameController gameController;
  TextPainter painter;
  Offset position;

  ScoreText(this.gameController) {
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
    if ((painter.text ?? '') != gameController.score.toString()) {
      painter.text = TextSpan(
        text: gameController.score.toString(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      );
      painter.layout();
      position = Offset(
        gameController.screenSize.width / 2 - painter.width / 2,
        gameController.screenSize.height * 0.2 - painter.height / 2,
      );
    }
  }
}
