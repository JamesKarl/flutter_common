import 'package:flutter/material.dart';

import '../ui.dart';

class BottomOneButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool strongPrompt;

  const BottomOneButton({
    Key key,
    @required this.text,
    this.textColor,
    this.backgroundColor,
    @required this.onPressed,
    this.strongPrompt = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        width: double.infinity,
        padding: Ui.bottomActionPadding,
        child: strongPrompt == true
            ? RaisedButton(
                shape: StadiumBorder(),
                child: Text(
                  text ?? "",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                color: backgroundColor,
                onPressed: onPressed,
              )
            : OutlineButton(
                shape: StadiumBorder(),
                child: Text(
                  text ?? "",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                color: backgroundColor,
                onPressed: onPressed,
              ),
      ),
    );
  }
}
