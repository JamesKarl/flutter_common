import 'package:flutter/material.dart';

import '../extentions/datetime_extensions.dart';
import '../picker.dart';

class DateNavigatorWidget extends StatelessWidget {
  const DateNavigatorWidget({
    Key key,
    @required this.dateNotifier,
  })  : assert(dateNotifier != null),
        super(key: key);

  final ValueNotifier<DateTime> dateNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            dateNotifier.value = dateNotifier.value.subtract(Duration(days: 1));
          },
        ),
        InkWell(
          child: ValueListenableBuilder(
            valueListenable: dateNotifier,
            builder: (BuildContext context, DateTime value, Widget child) {
              return Text(value.format());
            },
          ),
          onTap: () {
            Picker.of(context).pickDate(context).then((value) {
              if (value != null) {
                dateNotifier.value = value;
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            dateNotifier.value = dateNotifier.value.add(Duration(days: 1));
          },
        ),
      ],
    );
  }
}
