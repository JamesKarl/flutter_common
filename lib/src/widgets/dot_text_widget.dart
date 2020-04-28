import 'package:flutter/material.dart';

class DotTextWidget extends StatelessWidget {
  final double size;
  final double minRadius;
  final Color color;
  final String text;
  final TextStyle style;

  const DotTextWidget({
    Key key,
    this.size = 16.0,
    this.minRadius = 8.0,
    this.color = const Color(0xff1890FF),
    this.text = "起",
    this.style = const TextStyle(fontSize: 10, color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircleAvatar(
        minRadius: minRadius,
        backgroundColor: color,
        child: Text(text, style: style),
      ),
    );
  }
}
