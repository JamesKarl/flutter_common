import 'package:flutter/material.dart';

import '../ui.dart';
import '../picker.dart';
import 'date_interval.dart';
import '../extentions/datetime_extensions.dart';

class PickDateTimeIntervalPage extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;

  const PickDateTimeIntervalPage(
      {Key key,
      this.firstDate,
      this.lastDate,
      @required this.initialStartDate,
      @required this.initialEndDate})
      : super(key: key);

  @override
  _PickDateTimeIntervalPageState createState() =>
      _PickDateTimeIntervalPageState();
}

class _PickDateTimeIntervalPageState extends State<PickDateTimeIntervalPage> {
  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;

  DateTime selectStartDate;
  DateTime selectEndDate;

  final defaultDate = DateTime.now();

  DateInterval initialInterval;

  @override
  void initState() {
    selectStartDate = widget.initialStartDate;
    selectEndDate = widget.initialEndDate;
    initialInterval =
        DateInterval(widget.initialStartDate, widget.initialEndDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "选择时间区间",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 0),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        SizedBox(height: 16),
        buildCommonlyUsedItems(),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text("开始时间", style: Ui.keyTextStyle),
            Spacer(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  selectStartDate != null
                      ? selectStartDate.format(timePatternDashDisplay)
                      : "点击选择开始时间",
                  style: Ui.valueTextStyle,
                ),
              ),
              onTap: () {
                _pickStartDateTime(context);
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text("结束时间", style: Ui.keyTextStyle),
            Spacer(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  selectEndDate != null
                      ? selectEndDate.format(timePatternDashDisplay)
                      : "点击选择结束时间",
                  style: Ui.valueTextStyle,
                ),
              ),
              onTap: () {
                _pickEndDateTime(context);
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text("取消", style: TextStyle(color: btnColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("确定", style: TextStyle(color: btnColor)),
              onPressed: () {
                Navigator.of(context)
                    .pop(DateInterval(selectStartDate, selectEndDate));
              },
            )
          ],
        )
      ],
    );
  }

  Widget buildCommonlyUsedItems() {
    return GridView(
      shrinkWrap: true,
      children: PreferredDataInterval.all.map((it) {
        if (it.getDateInterval() == initialInterval) {
          return OutlineButton(
            color: Ui.btnBgColor,
            borderSide: BorderSide(color: Ui.btnBgColor),
            child: Text(
              it.label,
              style: TextStyle(color: Ui.btnBgColor),
            ),
            onPressed: () {
              Navigator.of(context).pop(it.getDateInterval());
            },
          );
        } else {
          return OutlineButton(
            child: Text(it.label),
            onPressed: () {
              Navigator.of(context).pop(it.getDateInterval());
            },
          );
        }
      }).toList(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          childAspectRatio: 2.5,
          mainAxisSpacing: 8.0),
    );
  }

  void _pickStartDateTime(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: startDate ??
                endDate?.subtract(Duration(days: 365)) ??
                defaultDate,
            firstDate: widget.firstDate,
            lastDate: endDate ?? defaultDate.add(Duration(days: 365)))
        .then((date) {
      if (date != null) {
        startDate = date;
        Picker.of(context)
            .pickTimeCustomWidget(
                context: context, initialTime: startTime ?? TimeOfDay.now())
            .then((time) {
          setState(() {
            if (time != null) {
              startTime = time;
              selectStartDate = DateTime(startDate.year, startDate.month,
                  startDate.day, startTime.hour, startTime.minute);
            }
          });
        });
      }
    });
  }

  void _pickEndDateTime(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: endDate ?? defaultDate,
            firstDate: startDate != null
                ? DateTime(startDate.year, startDate.month, startDate.day)
                : defaultDate.subtract(Duration(days: 365)),
            lastDate: widget.lastDate)
        .then((date) {
      if (date != null) {
        endDate = date;
        Picker.of(context)
            .pickTimeCustomWidget(
                context: context, initialTime: endTime ?? TimeOfDay.now())
            .then((time) {
          setState(() {
            endTime = time;
            selectEndDate = DateTime(endDate.year, endDate.month, endDate.day,
                endTime.hour, endTime.minute);
          });
        });
      }
    });
  }
}

class PreferredDataInterval {
  final String label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferredDataInterval &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode => label.hashCode;

  PreferredDataInterval(this.label);

  static final yesterday = PreferredDataInterval("昨天");
  static final today = PreferredDataInterval("今天");
  static final tomorrow = PreferredDataInterval("明天");

  static final in3Days = PreferredDataInterval("三天内");
  static final in7Days = PreferredDataInterval("一周内");
  static final in30Days = PreferredDataInterval("一月内");

  static final thisWeek = PreferredDataInterval("本周");
  static final thisMonth = PreferredDataInterval("本月");
  static final thisQuarter = PreferredDataInterval("本季度");

  static final all = [
    yesterday,
    today,
    tomorrow,
    in3Days,
    in7Days,
    in30Days,
    thisWeek,
    thisMonth,
    thisQuarter,
  ];

  DateInterval getDateInterval() {
    if (this == yesterday) {
      final date = DateTime.now().subtract(Duration(days: 1));
      return DateInterval(date.startOfDay(), date.endOfDay());
    }

    if (this == today) {
      final date = DateTime.now();
      return DateInterval(date.startOfDay(), date.endOfDay());
    }

    if (this == tomorrow) {
      final date = DateTime.now().add(Duration(days: 1));
      return DateInterval(date.startOfDay(), date.endOfDay());
    }

    if (this == in3Days) {
      final date = DateTime.now();
      return DateInterval(
        date.subtract(Duration(days: 3)).startOfDay(),
        date.endOfDay(),
      );
    }

    if (this == in7Days) {
      final date = DateTime.now();
      return DateInterval(
        date.subtract(Duration(days: 7)).startOfDay(),
        date.endOfDay(),
      );
    }

    if (this == in30Days) {
      final date = DateTime.now();
      return DateInterval(
        date.subtract(Duration(days: 30)).startOfDay(),
        date.endOfDay(),
      );
    }

    if (this == thisWeek) {
      final date = DateTime.now();
      final monday = date.subtract(Duration(days: date.weekday - 1));
      return DateInterval(
        monday.startOfDay(),
        monday.add(Duration(days: 6)).endOfDay(),
      );
    }

    if (this == thisMonth) {
      final date = DateTime.now();
      final firstDay = DateTime(date.year, date.month, 1);
      final lastDay =
          DateTime(date.year, date.month + 1, 1).subtract(Duration(days: 1));
      return DateInterval(
        firstDay.startOfDay(),
        lastDay.endOfDay(),
      );
    }

    if (this == thisQuarter) {
      final date = DateTime.now();
      final month = date.month;
      if (month >= 1 && month <= 3) {
        return DateInterval(
          DateTime(date.year, 1, 1).startOfDay(),
          DateTime(date.year, 3, 31).endOfDay(),
        );
      } else if (month >= 4 && month <= 6) {
        return DateInterval(
          DateTime(date.year, 4, 1).startOfDay(),
          DateTime(date.year, 6, 30).endOfDay(),
        );
      } else if (month >= 7 && month <= 9) {
        return DateInterval(
          DateTime(date.year, 7, 1).startOfDay(),
          DateTime(date.year, 9, 30).endOfDay(),
        );
      } else {
        return DateInterval(
          DateTime(date.year, 10, 1).startOfDay(),
          DateTime(date.year, 12, 31).endOfDay(),
        );
      }
    }
    return null;
  }
}
