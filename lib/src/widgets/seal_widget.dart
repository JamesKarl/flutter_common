import 'dart:math';

import 'package:flutter/material.dart';

class SealWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double height;

  const SealWidget({
    Key key,
    @required this.text,
    this.color,
    this.height,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theColor = Theme.of(context).primaryColor;
    return Transform.rotate(
      angle: pi / 8,
      child: SizedBox(
        height: height ?? 32,
        child: OutlineButton(
          child: Text(
            text,
            style: TextStyle(
              color: theColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: null,
          disabledBorderColor: theColor,
          borderSide: BorderSide(width: 2.0),
        ),
      ),
    );
  }
}
