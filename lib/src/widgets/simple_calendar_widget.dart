import 'package:flutter/material.dart';

typedef OnTapDayWrapper = void Function(DateTimeWrapper date);

enum DayStatus {
  available,
  unavailable,
  focused,
}

class DateTimeWrapper {
  DayStatus status;
  DateTime date;

  DateTimeWrapper(this.status, this.date);
}

class SimpleCalendarWidget extends StatefulWidget {
  final List<DateTimeWrapper> dates;

  const SimpleCalendarWidget({
    Key key,
    @required this.dates,
  })  : assert(dates != null),
        super(key: key);

  @override
  _SimpleCalendarWidgetState createState() => _SimpleCalendarWidgetState();
}

class _SimpleCalendarWidgetState extends State<SimpleCalendarWidget> {
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.dates
          .map((date) => DayWidget(
                date: date,
                onTapDay: onTapDay,
              ))
          .toList(),
    );
  }

  void onTapDay(DateTimeWrapper date) {
    setState(() {
      widget.dates.forEach((d) => d.status = DayStatus.available);
      date.status = DayStatus.focused;
    });
  }
}

class DayWidget extends StatelessWidget {
  final DateTimeWrapper date;
  final OnTapDayWrapper onTapDay;

  const DayWidget({
    Key key,
    this.date,
    this.onTapDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        key: ValueKey(date.status),
        backgroundColor:
            date.status == DayStatus.available ? Colors.grey : Colors.orange,
        child: Text(
          date.date.day.toString(),
          style: TextStyle(
            color: date.status == DayStatus.available
                ? Colors.black26
                : Colors.white,
          ),
        ),
      ),
      onTap: () {
        onTapDay(date);
      },
    );
  }
}
