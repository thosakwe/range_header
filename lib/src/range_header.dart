import 'range_header_item.dart';

/// Represents the contents of a parsed `Range` header.
abstract class RangeHeader {
  /// Returns an immutable list of the ranges that were parsed.
  List<RangeHeaderItem> get ranges;

  /// Returns this header's range unit. Most commonly, this is `bytes`.
  String get rangeUnit;

  /// Creates a representation of this instance suitable for a `Content-Range` header.
  ///
  /// This can only be used if the user request only one range. If not, send a
  /// `multipart/byteranges` response.
  ///
  /// Please adhere to the standard!!!
  /// http://httpwg.org/specs/rfc7233.html
  String toContentRange([int totalSize]) {
    if (ranges.length != 1)
      throw new StateError(
          'toContentRange only supports when `ranges` has a length of 1.');
    var denominator = totalSize != null ? totalSize.toString() : '*';
    return '${ranges[0]}/$denominator';
  }
}
