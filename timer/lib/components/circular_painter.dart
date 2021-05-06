import 'dart:math';

import 'package:flutter/material.dart';

class CircularPainter extends CustomPainter {
  Animation<double> animation;
  Color backgroundColor, color;

  CircularPainter(this.animation, this.backgroundColor, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    paint.color = color;
    final progress = (1 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
