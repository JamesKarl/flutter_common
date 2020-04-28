import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const timePatternDashDisplay = "yyyy-MM-dd HH:mm";
const timePatternDashFull = "yyyy-MM-dd HH:mm:ss";
const timePatternDashDate = "yyyy-MM-dd HH:mm:ss";
const timePatternMonthDay = "MM月dd日";
const timePatternMonthDayDash = "MM-dd";
const timePatternYearMonthDay = "yyyy年MM月dd日";
const timePatternYearMonthDash = "yyyy-MM-dd";
const timePatternYearMonthDayHourMinuteCN = "yyyy年MM月dd日 HH:mm";
const timePatternMonthDayHourMinuteCN = "MM月dd日 HH:mm";
const timePatternMonthDayHourMinuteSlash = "MM/dd HH:mm";
const timePatternYearMonthDayHourMinute = "yyyy.MM.dd HH:mm";
const timePatternYearMonthDayDot = "yyyy.MM.dd";
const timePatternTimeStamp = "yyyyMMddHHmm";
const timePatternHourMinute = "HH:mm";

extension DateTimeExtentions on DateTime {
  String format([String pattern = "yyyy-MM-dd"]) {
    try {
      return DateFormat(pattern).format(this);
    } catch (e) {
      return this.toString();
    }
  }

  DateTime startOfDay() => DateTime(year, month, day);

  DateTime endOfDay() => DateTime(year, month, day, 23, 59, 59);

  bool sameDayAs(DateTime other) =>
      other != null &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  bool beforeToday() =>
      DateTime.now().startOfDay().millisecondsSinceEpoch >
      this.millisecondsSinceEpoch;

  bool afterToday() =>
      DateTime.now().endOfDay().millisecondsSinceEpoch <
      this.millisecondsSinceEpoch;

  bool isToday() => this.sameDayAs(DateTime.now());

  DateTime monthStart() => DateTime(year, month, 1, 00, 00);

  DateTime yesterday() => this.subtract(Duration(days: 1)).startOfDay();

  List<DateTime> nextXDays(int num, {DateTime formNowOn}) {
    assert(num >= 2);
    final now = (formNowOn ?? DateTime.now()).startOfDay();
    return List.generate(num, (it) => now.add(Duration(days: it)));
  }
}

extension TimeOfDayExtentions on TimeOfDay {
  DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}