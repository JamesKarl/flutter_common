import 'package:flutter/material.dart';
import 'date_interval.dart';
import 'pick_date_interval_page.dart';
import 'pick_date_time.dart';
import 'pick_datetime_interval_page.dart';
import 'pick_time_section.dart';

mixin DateTimePicker {
  ///选择日期区间
  Future<DateInterval> pickDateInterval(
    BuildContext context, {
    @required DateTime initialStartDate,
    @required DateTime initialEndDate,
    DateTime firstDate,
    DateTime lastDate,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return PickDateIntervalPage(
            initialStartDate: initialStartDate,
            initialEndDate: initialEndDate,
            firstDate:
                firstDate ?? DateTime.now().subtract(Duration(days: 365 * 10)),
            lastDate: lastDate ?? DateTime.now().add(Duration(days: 365 * 10)),
          );
        });
  }

  ///选择日期时间区间
  Future<DateInterval> pickDateTimeInterval(
    BuildContext context, {
    @required DateTime initialStartDate,
    @required DateTime initialEndDate,
    DateTime firstDate,
    DateTime lastDate,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return PickDateTimeIntervalPage(
            initialStartDate: initialStartDate,
            initialEndDate: initialEndDate,
            firstDate:
                firstDate ?? DateTime.now().subtract(Duration(days: 365 * 10)),
            lastDate: lastDate ?? DateTime.now().add(Duration(days: 365 * 10)),
          );
        });
  }

  Future pickTimeCustomWidget({
    BuildContext context,
    TimeOfDay initialTime,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return PickTimeSection(initialTime: initialTime);
        });
  }

  ///选择日期区间
  Future<DateInterval> pickDateInterval2(
    BuildContext context, {
    @required DateTime initialStartDate,
    @required DateTime initialEndDate,
    DateTime firstDate,
    DateTime lastDate,
  }) {
    return PickDateTime.pickDateInterval(context,
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        firstDate: firstDate,
        lastDate: lastDate);
  }

  ///选择日期和时间
  Future<DateTime> pickDateTime(BuildContext context, DateTime firstDate,
      DateTime lastDate, DateTime initialDate,
      {int deltaMinutes = 0}) async {
    return PickDateTime.pickDateTime(context, firstDate, lastDate, initialDate,
        deltaMinutes: deltaMinutes);
  }

  ///选择时间
  Future<TimeOfDay> pickTime(
      BuildContext context, TimeOfDay initialTime) async {
    return PickDateTime.pickTime(context, initialTime);
  }

  ///选择日期
  Future<DateTime> pickDate(BuildContext context,
      {DateTime firstDate, DateTime lastDate, DateTime initialDate}) async {
    return PickDateTime.pickDate(context, firstDate, lastDate, initialDate);
  }
}
