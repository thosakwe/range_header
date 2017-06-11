import 'range_header.dart';
import 'range_header_item.dart';

/// Represents the contents of a parsed `Range` header.
class RangeHeaderImpl extends RangeHeader {
  List<RangeHeaderItem> _cached;
  final List<RangeHeaderItem> _items = [];

  RangeHeaderImpl(this.rangeUnit, [List<RangeHeaderItem> items = const []]) {
    this._items.addAll(items ?? []);
  }

  @override
  List<RangeHeaderItem> get ranges =>
      _cached ?? (_cached = new List<RangeHeaderItem>.unmodifiable(_items));

  @override
  final String rangeUnit;
}
