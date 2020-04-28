import 'package:intl/intl.dart';

extension NumExtentions on num {
  ///把数字格式化为人民币（带分隔符）
  String rmb() {
    return NumberFormat.currency(
            symbol: "", decimalDigits: 2, customPattern: "##,##0.0#")
        .format(this);
  }

  String asDistance() {
    if (this < 1.0) return "${(this * 1000).round()} m";
    if (this < 10.0) return "${this.toStringAsFixed(1)} km";
    return "${this.round()} km";
  }

  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
