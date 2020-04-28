import 'dart:math';

import 'package:flutter/material.dart';

class DashCircleDividerWidget extends StatelessWidget {
  final double radius;
  final Color color;
  final Color backgroundColor;
  final double dashWidth;
  final double dashHeight;
  final Color dashColor;

  const DashCircleDividerWidget({
    Key key,
    this.radius = 8.0,
    this.color = Colors.transparent,
    this.backgroundColor = Colors.white,
    this.dashHeight = 3,
    this.dashWidth = 5,
    this.dashColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        if (width < 4 * radius) {
          return Offstage();
        }
        return SizedBox(
          width: width,
          height: 2 * radius,
          child: CustomPaint(
            painter: _DashCircleDividerPainter(
              radius: radius,
              color: color,
              backgroundColor: backgroundColor,
              dashColor: dashColor,
              dashHeight: dashHeight,
              dashWidth: dashWidth,
            ),
          ),
        );
      },
    );
  }
}

class _DashCircleDividerPainter extends CustomPainter {
  final double radius;
  final Color color;
  final Color backgroundColor;
  final bool showRightHalf;
  final double dashWidth;
  final double dashHeight;
  final Color dashColor;

  _DashCircleDividerPainter({
    this.radius = 8,
    this.color = Colors.red,
    this.showRightHalf = true,
    this.backgroundColor = Colors.white,
    this.dashHeight = 3,
    this.dashWidth = 5,
    this.dashColor = Colors.red,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print("HalfCirclePaint size = $size");
    final paint = Paint();

    paint.color = backgroundColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    paint.color = color;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, radius), radius: radius),
      -pi / 2,
      pi * 2,
      true,
      paint,
    );

    canvas.translate(size.width - 2 * radius, 0);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(2 * radius, radius), radius: radius),
      pi / 2,
      pi * 2,
      true,
      paint,
    );

    canvas.translate(-size.width + 2 * radius + dashWidth, radius);

    paint.color = dashColor;
    paint.strokeWidth = dashHeight;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeCap = StrokeCap.round;
    double startX = radius;
    final maxX = size.width - radius - dashWidth * 2;
    while (startX < maxX) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth * 2;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is _DashCircleDividerPainter &&
        (oldDelegate.color != color || oldDelegate.radius != radius);
  }
}
