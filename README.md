# range_header
[![Pub](https://img.shields.io/pub/v/range_header.svg)](https://pub.dartlang.org/packages/range_header)
[![build status](https://travis-ci.org/thosakwe/range_header.svg)](https://travis-ci.org/thosakwe/range_header)
![coverage: 100%](https://img.shields.io/badge/coverage-100%25-green.svg)

Range header parser for Dart.
# Usage
```dart
handleRequest(HttpRequest request) async {
  // Parse the header
  var header = parseRangeHeader(request.headers.value(HttpHeaders.RANGE));
  
  // Get info
  header.items;
  header.rangeUnit;
  header.toContentRange();
}
```

This package powers `package:angel_range` as well.
