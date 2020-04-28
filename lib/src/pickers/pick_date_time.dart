import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui.dart';
import '../picker.dart';
import '../extentions/datetime_extensions.dart';
import '../extentions/build_context_extentions.dart';

import 'date_interval.dart';

abstract class PickDateTime {
  ///选择日期
  static Future<DateTime> pickDate(BuildContext context, DateTime firstDate,
      DateTime lastDate, DateTime initialDate) async {
    DateTime now = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(now.year - 1),
      lastDate: lastDate ?? DateTime(now.year + 1),
    );
  }

  ///选择时间
  static Future<TimeOfDay> pickTime(
      BuildContext context, TimeOfDay initialTime) async {
    return await Picker.of(context).pickTimeCustomWidget(
        context: context, initialTime: initialTime);
  }

  ///选择日期和时间
  static Future<DateTime> pickDateTime(BuildContext context, DateTime firstDate,
      DateTime lastDate, DateTime initialDate,
      {int deltaMinutes = 0}) async {
    final date = await pickDate(context, firstDate, lastDate, initialDate);
    if (date != null) {
      final initialTime = initialDate != null
          ? TimeOfDay.fromDateTime(initialDate)
          : TimeOfDay.now();
      final time = await pickTime(context, initialTime);
      if (time != null) {
        return DateTime(date.year, date.month, date.day, time.hour,
            time.minute + deltaMinutes);
      }
    }
    return null;
  }

  ///选择日期
  static Future<DateTime> iOSPickDate(BuildContext context, DateTime firstDate,
      DateTime lastDate, DateTime initialDate) async {
    DateTime pickedDate = initialDate;
    bool confirmSelection = false;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _createPickerActionBar(context, "选择日期", () {
                  confirmSelection = true;
                  return true;
                }),
                _buildBottomPicker(CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumYear: firstDate.year + 1,
                  initialDateTime: initialDate,
                  onDateTimeChanged: (DateTime newDateTime) {
                    pickedDate = newDateTime;
                  },
                )),
              ],
            );
          },
          onClosing: () {},
        );
      },
    );
    return confirmSelection ? pickedDate : initialDate;
  }

  ///选择日期和时间
  static Future<DateTime> iOSPickDateTime(BuildContext context,
      DateTime firstDate, DateTime lastDate, DateTime initialDate) async {
    DateTime pickedDate = initialDate;
    bool confirmSelection = false;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _createPickerActionBar(context, "选择日期时间", () {
                  confirmSelection = true;
                  return true;
                }),
                _buildBottomPicker(CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  initialDateTime: initialDate,
                  onDateTimeChanged: (DateTime newDateTime) {
                    pickedDate = newDateTime;
                  },
                )),
              ],
            );
          },
          onClosing: () {},
        );
      },
    );
    return confirmSelection ? pickedDate : initialDate;
  }

  ///选择时间
  static Future<TimeOfDay> iOSPickTime(
      BuildContext context, TimeOfDay initialTime) async {
    final now = DateTime.now();
    TimeOfDay pickedTime = initialTime;
    bool confirmSelection = false;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _createPickerActionBar(context, "选择时间", () {
                  confirmSelection = true;
                  return true;
                }),
                _buildBottomPicker(CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  minimumDate: now.startOfDay(),
                  maximumDate: now.endOfDay(),
                  initialDateTime: DateTime(now.year, now.month, now.day,
                      initialTime.hour, initialTime.minute),
                  onDateTimeChanged: (DateTime newDateTime) {
                    pickedTime = TimeOfDay(
                        hour: newDateTime.hour, minute: newDateTime.minute);
                  },
                )),
              ],
            );
          },
          onClosing: () {},
        );
      },
    );
    return confirmSelection ? pickedTime : initialTime;
  }

  ///选择日期区间
  static Future<DateInterval> pickDateInterval(
    BuildContext context, {
    @required DateTime initialStartDate,
    @required DateTime initialEndDate,
    DateTime firstDate,
    DateTime lastDate,
  }) async {
    DateTime pickedStartDate = initialStartDate;
    DateTime pickedEndDate = initialEndDate;
    bool confirmSelection = false;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheet(
          builder: (BuildContext context) {
            return SizedBox(
              height: 360,
              child: Scaffold(
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Builder(
                      builder: (BuildContext context) {
                        return _createPickerActionBar(context, "选择日期区间", () {
                          confirmSelection = true;
                          if (pickedStartDate.millisecondsSinceEpoch -
                                  pickedEndDate.millisecondsSinceEpoch >
                              0) {
                            context.showSnackBar("结束日期早于开始日期, 请重新选择");
                            return false;
                          }
                          return true;
                        });
                      },
                    ),
                    _buildBottomPicker(
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                child: TabBar(
                                  indicatorColor: Color(0xff108EE9),
                                  labelColor: Color(0xff108EE9),
                                  unselectedLabelColor: Color(0xffbfbfbf),
                                  tabs: <Widget>[
                                    Tab(text: "开始日期"),
                                    Tab(text: "结束日期"),
                                  ],
                                ),
                              ),
                              Container(
                                height: 260,
                                color: Ui.pageBackground,
                                child: TabBarView(
                                  children: <Widget>[
                                    CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      maximumYear: firstDate.year + 1,
                                      initialDateTime: initialStartDate,
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        pickedStartDate = newDateTime;
                                      },
                                    ),
                                    CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      maximumYear: firstDate.year + 1,
                                      initialDateTime: initialEndDate,
                                      onDateTimeChanged:
                                          (DateTime newDateTime) {
                                        pickedEndDate = newDateTime;
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        height: 315),
                  ],
                ),
              ),
            );
          },
          onClosing: () {},
        );
      },
    );
    return confirmSelection
        ? DateInterval(pickedStartDate, pickedEndDate)
        : DateInterval(initialStartDate, initialEndDate);
  }

  static const double _kPickerSheetHeight = 216.0;

  static Widget _buildBottomPicker(Widget picker,
      {double height = _kPickerSheetHeight}) {
    return Container(
      height: height,
      padding: const EdgeInsets.only(top: 6.0),
      color: Ui.pageBackground,
      child: DefaultTextStyle(
        style: Ui.valueTextStyle,
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  static Widget _createPickerActionBar(BuildContext context, String titleString,
      bool Function() onConfirmClicked) {
    final actionStyle = const TextStyle(color: Color(0xff108EE9), fontSize: 17);
    final titleStyle = const TextStyle(color: Colors.black, fontSize: 17);
    return SizedBox(
      height: 42,
      child: Row(
        children: <Widget>[
          FlatButton(
              child: Text(
                "取消",
                style: actionStyle,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          Spacer(),
          Text(titleString, style: titleStyle),
          Spacer(),
          FlatButton(
            child: Text(
              "确定",
              style: actionStyle,
            ),
            onPressed: () {
              if (onConfirmClicked()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
