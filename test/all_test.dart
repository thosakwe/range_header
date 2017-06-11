import 'package:range_header/range_header.dart';
import 'package:test/test.dart';

final Matcher throwsRangeParseException =
    throwsA(const isInstanceOf<RangeHeaderParseException>());

main() {
  group('one item', () {
    test('start and end', () {
      var r = parseRangeHeader('bytes 1-200');
      expect(r.ranges, hasLength(1));
      expect(r.ranges.first.start, 1);
      expect(r.ranges.first.end, 200);
    });

    test('start only', () {
      var r = parseRangeHeader('bytes 1-');
      expect(r.ranges, hasLength(1));
      expect(r.ranges.first.start, 1);
      expect(r.ranges.first.end, -1);
    });

    test('end only', () {
      var r = parseRangeHeader('bytes -200');
      print(r.ranges);
      expect(r.ranges, hasLength(1));
      expect(r.ranges.first.start, -1);
      expect(r.ranges.first.end, 200);
    });
  });

  group('multiple items', () {
    test('three items', () {
      var r = parseRangeHeader('bytes 1-20, 21-40, 41-60');
      print(r.ranges);
      expect(r.ranges, hasLength(3));
      expect(r.ranges[0].start, 1);
      expect(r.ranges[0].end, 20);
      expect(r.ranges[1].start, 21);
      expect(r.ranges[1].end, 40);
      expect(r.ranges[2].start, 41);
      expect(r.ranges[2].end, 60);
    });

    test('one item without end', () {
      var r = parseRangeHeader('bytes 1-20, 21-');
      print(r.ranges);
      expect(r.ranges, hasLength(2));
      expect(r.ranges[0].start, 1);
      expect(r.ranges[0].end, 20);
      expect(r.ranges[1].start, 21);
      expect(r.ranges[1].end, -1);
    });
  });

  group('failures', () {
    test('no start with no end', () {
      expect(parseRangeHeader('-'), isNull);
    });
  });

  group('exceptions', () {
    test('invalid character', () {
      expect(() => parseRangeHeader('!!!'), throwsRangeParseException);
    });

    test('no ranges', () {
      expect(() => parseRangeHeader('bytes'), throwsRangeParseException);
    });

    test('no dash after int', () {
      expect(() => parseRangeHeader('bytes 3'), throwsRangeParseException);
      expect(() => parseRangeHeader('bytes 3,'), throwsRangeParseException);
      expect(() => parseRangeHeader('bytes 3 24'), throwsRangeParseException);
    });


    test('no int after dash', () {
      expect(() => parseRangeHeader('bytes -,'), throwsRangeParseException);
    });

    test('content-range from multiple', () {
      expect(() {
        var r = parseRangeHeader('bytes 1-2, 3-4');
        return r.toContentRange();
      }, throwsStateError);
    });
  });

  group('complete coverage', () {
    test('exception toString()', () {
      var m = new RangeHeaderParseException('hey');
      expect(m.toString(), contains('hey'));
    });
  });

  test('content-range', () {
    expect(parseRangeHeader('bytes 1-2').toContentRange(3), '1-2/3');
  });
}
