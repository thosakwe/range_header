import 'src/range_header.dart';
import 'src/parser.dart';
export 'src/exception.dart';
export 'src/range_header.dart';
export 'src/range_header_item.dart';

/// Attempts to parse a [RangeHeader] from its [text] representation.
///
/// You can optionally pass a custom list of [allowedRangeUnits].
/// The default is `['bytes']`.
RangeHeader parseRangeHeader(String text,
    {Iterable<String> allowedRangeUnits}) {
  var tokens = scan(text, allowedRangeUnits?.toList() ?? ['bytes']);
  var parser = new Parser(tokens);
  return parser.parseRangeHeader();
}
