import 'package:flutter/material.dart';

import '../ui.dart';
import 'date_interval.dart';
import 'pick_datetime_interval_page.dart';
import '../extentions/datetime_extensions.dart';

class PickDateIntervalPage extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;

  const PickDateIntervalPage(
      {Key key,
      this.firstDate,
      this.lastDate,
      @required this.initialStartDate,
      @required this.initialEndDate})
      : super(key: key);

  @override
  _PickDateIntervalPageState createState() => _PickDateIntervalPageState();
}

class _PickDateIntervalPageState extends State<PickDateIntervalPage> {
  DateTime startDate;
  DateTime endDate;

  final defaultDate = DateTime.now();

  DateInterval initialInterval;

  @override
  void initState() {
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
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
            "选择日期区间",
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
                  startDate != null ? startDate.format() : "点击选择开始日期",
                  style: Ui.valueTextStyle,
                ),
              ),
              onTap: () {
                _pickStartDate(context);
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
                  endDate != null ? endDate.format() : "点击选择结束日期",
                  style: Ui.valueTextStyle,
                ),
              ),
              onTap: () {
                _pickEndDate(context);
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
                Navigator.of(context).pop(DateInterval(startDate, endDate));
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

  void _pickStartDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: startDate ??
                endDate?.subtract(Duration(days: 1)) ??
                defaultDate,
            firstDate: widget.firstDate,
            lastDate: endDate ?? defaultDate.add(Duration(days: 365)))
        .then((date) {
      if (date != null) {
        setState(() {
          startDate = date;
        });
      }
    });
  }

  void _pickEndDate(BuildContext context) {
    debugPrint(
        "firstDate: ${startDate.format()}, lastDate: ${widget.lastDate.format()}, initialDate: ${endDate.format()}");
    final firstDate = startDate != null
        ? DateTime(startDate.year, startDate.month, startDate.day)
        : defaultDate.subtract(Duration(days: 365));

    final initialDate = endDate ?? defaultDate;
    showDatePicker(
            context: context,
            initialDate:
                initialDate.isBefore(firstDate) ? firstDate : initialDate,
            firstDate: firstDate,
            lastDate: widget.lastDate)
        .then((date) {
      if (date != null) {
        setState(() {
          endDate = date;
        });
      }
    });
  }
}
