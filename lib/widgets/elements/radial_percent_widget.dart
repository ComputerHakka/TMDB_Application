import 'dart:math';

import 'package:flutter/material.dart';

class RadialPercentWidget extends StatelessWidget {
  final Widget child;
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  const RadialPercentWidget(
      {super.key,
      required this.child,
      required this.percent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor,
      required this.lineWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: RadialPercentPainter(
              percent: percent,
              fillColor: fillColor,
              lineColor: lineColor,
              freeColor: freeColor,
              lineWidth: lineWidth),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Center(child: child),
        ),
      ],
    );
  }
}

class RadialPercentPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  RadialPercentPainter(
      {super.repaint,
      required this.percent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor,
      required this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Rect arcRect = calculateArcsRect(size);

    drawBackground(canvas, size);

    drawFreeArc(canvas, arcRect);

    drawFilledArc(canvas, arcRect);
  }

  void drawFilledArc(Canvas canvas, Rect arcRect) {
    final feelPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, -pi / 2, pi * 2 * percent, false, feelPaint);
  }

  void drawFreeArc(Canvas canvas, Rect arcRect) {
    final paint = Paint()
      ..color = freeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    canvas.drawArc(arcRect, pi * 2 * percent - (pi / 2),
        pi * 2 * (1.0 - percent), false, paint);
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, paint);
  }

  Rect calculateArcsRect(Size size) {
    const linesMargin = 3;
    final offset = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);
    return arcRect;
  }

  @override
  bool shouldRepaint(RadialPercentPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(RadialPercentPainter oldDelegate) => true;
}
