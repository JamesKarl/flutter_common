class DateInterval {
  DateTime start;
  DateTime end;

  DateInterval(this.start, this.end);

  bool get isEmpty => start == null && end == null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateInterval &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'DateInterval{start: $start, end: $end}';
  }
}
