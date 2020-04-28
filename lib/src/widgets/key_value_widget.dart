import 'package:flutter/material.dart';

import '../global.dart';

class KeyValueWidget extends StatelessWidget {
  final String keyText;
  final String valueText;
  final TextStyle keyStyle;
  final TextStyle valueStyle;
  final Widget keyWidget;
  final Widget valueWidget;
  final CrossAxisAlignment crossAxisAlignment;
  final bool widthMatchParent;
  final EdgeInsets padding;

  const KeyValueWidget({
    Key key,
    this.keyText,
    this.valueText,
    this.keyStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 14,
    ),
    this.valueStyle = const TextStyle(
      color: const Color(0xff252525),
      fontSize: 14,
      //fontWeight: FontWeight.bold,
    ),
    this.keyWidget,
    this.valueWidget,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.widthMatchParent = false,
    this.padding = const EdgeInsets.only(top: 4),
  })  : assert(widthMatchParent != null),
        assert(padding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          if (keyWidget != null)
            keyWidget
          else
            Text(
              keyText ?? NDP,
              style: keyStyle,
            ),
          valueWidget == null && widthMatchParent == true
              ? Spacer()
              : SizedBox(width: 4),
          if (valueWidget != null)
            Expanded(child: valueWidget)
          else if (widthMatchParent == true)
            Text(
              valueText ?? NDP,
              style: valueStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          else
            Expanded(
              child: Text(
                valueText ?? NDP,
                style: valueStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

class TweenKeyValueWidget extends StatelessWidget {
  final String leftKeyText;
  final String leftValueText;
  final TextStyle leftKeyStyle;
  final TextStyle leftValueStyle;
  final Widget leftKeyWidget;
  final Widget leftValueWidget;

  final String rightKeyText;
  final String rightValueText;
  final TextStyle rightKeyStyle;
  final TextStyle rightValueStyle;
  final Widget rightKeyWidget;
  final Widget rightValueWidget;
  final bool keyValueOneLine;

  const TweenKeyValueWidget({
    Key key,
    this.leftKeyText,
    this.leftValueText,
    this.leftKeyStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 14,
    ),
    this.leftValueStyle = const TextStyle(
      color: const Color(0xff252525),
      fontSize: 14,
    ),
    this.leftKeyWidget,
    this.leftValueWidget,
    this.rightKeyText,
    this.rightValueText,
    this.rightKeyStyle = const TextStyle(
      color: const Color(0xff999999),
      fontSize: 14,
    ),
    this.rightValueStyle = const TextStyle(
      color: const Color(0xff252525),
      fontSize: 14,
    ),
    this.rightKeyWidget,
    this.rightValueWidget,
    this.keyValueOneLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return keyValueOneLine ? buildKeyValueOneLine() : buildKeyValueTwoLine();
  }

  Widget buildKeyValueOneLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (leftKeyWidget != null)
          leftKeyWidget
        else
          Text(
            leftKeyText ?? NDP,
            style: leftKeyStyle,
          ),
        SizedBox(width: 4),
        if (leftValueWidget != null)
          leftValueWidget
        else
          Text(
            leftValueText ?? NDP,
            style: leftValueStyle,
          ),
        Spacer(),
        if (rightKeyWidget != null)
          rightKeyWidget
        else
          Text(
            rightKeyText ?? NDP,
            style: rightKeyStyle,
          ),
        SizedBox(width: 4),
        if (rightValueWidget != null)
          rightValueWidget
        else
          Text(
            rightValueText ?? NDP,
            style: rightValueStyle,
          ),
      ],
    );
  }

  Widget buildKeyValueTwoLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (leftKeyWidget != null)
              leftKeyWidget
            else
              Text(
                leftKeyText ?? NDP,
                style: leftKeyStyle,
              ),
            SizedBox(height: 4),
            if (leftValueWidget != null)
              leftValueWidget
            else
              Text(
                leftValueText ?? NDP,
                style: leftValueStyle,
              ),
          ],
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (rightKeyWidget != null)
              rightKeyWidget
            else if (rightKeyText != null)
              Text(
                rightKeyText ?? NDP,
                style: rightKeyStyle,
                textAlign: TextAlign.end,
              ),
            SizedBox(height: 4),
            if (rightValueWidget != null)
              rightValueWidget
            else
              Text(
                rightValueText ?? NDP,
                style: rightValueStyle,
                textAlign: TextAlign.end,
              ),
          ],
        ),
      ],
    );
  }
}
