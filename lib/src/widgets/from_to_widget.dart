import 'package:flutter/material.dart';

import '../global.dart';
import '../ui.dart';

class FromToWidget extends StatelessWidget {
  final String fromText;
  final String fromSubText;
  final String toText;
  final String toSubText;
  final Color textColor;
  final bool showTips;
  final Widget rightWidget;
  final TextStyle textStyle;

  const FromToWidget({
    Key key,
    this.fromText,
    this.toText,
    this.textColor = const Color(0xff666666),
    this.showTips = false,
    this.rightWidget,
    this.fromSubText,
    this.toSubText,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4.0),
            Ui.fromDot,
            SizedBox(height: 2.0),
            Expanded(
              child: VerticalDivider(
                color: Ui.lineColor,
                thickness: 1,
                width: 16,
              ),
            ),
            SizedBox(height: 2.0),
            Ui.toDot,
            SizedBox(height: 2.0),
            if (toSubText != null) SizedBox(height: 2)
          ],
        )),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildFromSection(context),
              if (fromSubText != null) _buildFromSubtitle(),
              SizedBox(height: 12.0),
              buildToSection(context),
              if (toSubText != null) _buildToSubtitle(),
            ],
          ),
        ),
        if (rightWidget != null)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Align(
              child: rightWidget,
              alignment: Alignment.centerRight,
            ),
          ),
      ],
    );
  }

  Row buildToSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTips(Ui.toText),
        Expanded(
          flex: 1,
          child: Text(
            toText ?? NDP,
            style: textStyle ?? Ui.subjectTextStyle,
          ),
        )
      ],
    );
  }

  Row buildFromSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTips(Ui.fromText),
        Expanded(
          child: Text(
            fromText ?? NDP,
            style: textStyle ?? Ui.subjectTextStyle,
          ),
        )
      ],
    );
  }

  Widget _buildTips(Text text) {
    if (showTips) {
      return Padding(
        padding: EdgeInsets.only(right: Ui.pagePadding),
        child: text,
      );
    } else {
      return Container();
    }
  }

  Widget _buildFromSubtitle() {
    return Text(fromSubText, style: Ui.detailTextStyle);
  }

  Widget _buildToSubtitle() {
    return Text(toSubText, style: Ui.detailTextStyle);
  }
}
