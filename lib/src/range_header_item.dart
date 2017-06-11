/// Represents an individual range, with an optional start index and optional end index.
class RangeHeaderItem {
  /// The index at which this chunk begins. May be `-1`.
  final int start;

  /// The index at which this chunk ends. May be `-1`.
  final int end;

  RangeHeaderItem([this.start = -1, this.end = -1]);

  @override
  String toString() {
    if (start > -1 && end > -1)
      return '$start-$end';
    else if (start > -1)
      return '$start-';
    else return '-$end';
  }
}
