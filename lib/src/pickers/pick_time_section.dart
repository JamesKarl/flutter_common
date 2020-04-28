import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickTimeSection extends StatefulWidget {
  final TimeOfDay initialTime;

  const PickTimeSection({
    Key key,
    this.initialTime,
  }) : super(key: key);

  @override
  _PickTimeSectionState createState() => _PickTimeSectionState();
}

class _PickTimeSectionState extends State<PickTimeSection> {
  TimeOfDay timeOfDay;

  @override
  void initState() {
    timeOfDay = widget.initialTime ?? TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);

    Color backgroundColor;
    switch (themeData.brightness) {
      case Brightness.light:
        backgroundColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        backgroundColor = themeData.backgroundColor;
        break;
    }

    Color btnColor = const Color(0xff2196F3);

    return SimpleDialog(
      title: Container(
        height: 64,
        color: backgroundColor,
        child: Center(
            child: Text(
          "选择时间",
          style: TextStyle(color: Colors.white),
        )),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        SizedBox(
          height: 160,
          child: CupertinoTimerPicker(
            initialTimerDuration: Duration(
              hours: timeOfDay.hour,
              minutes: timeOfDay.minute,
            ),
            mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (Duration value) {
              timeOfDay = TimeOfDay(
                hour: value.inHours,
                minute: value.inMinutes - value.inHours * 60,
              );
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            FlatButton(
              child: Text(
                localizations.cancelButtonLabel,
                style: TextStyle(color: btnColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            FlatButton(
              child: Text(
                localizations.okButtonLabel,
                style: TextStyle(color: btnColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(timeOfDay);
              },
            ),
          ],
        ),
      ],
    );
  }
}
