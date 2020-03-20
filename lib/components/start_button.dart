import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xania/game_controller.dart';

class StartButton {
  final GameController gameController;
  Offset position;
  TextPainter painter;

  StartButton(this.gameController) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  //here to update the score
  void update(double t) {
    painter.text = TextSpan(
      text: 'START',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 50.0,
      ),
    );
    painter.layout();
    position = Offset(
      gameController.screenSize.width / 2 - painter.width / 2,
      gameController.screenSize.height * 0.75 - painter.height / 2,
    );
  }
}
