import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;

  final bool strongPrompt;

  const FullWidthButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.textStyle,
    this.strongPrompt = true,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: strongPrompt
          ? RaisedButton(
              onPressed: onPressed,
              child: Text(text, style: textStyle),
            )
          : OutlineButton(
              onPressed: onPressed,
              child: Text(text, style: textStyle),
            ),
    );
  }
}
