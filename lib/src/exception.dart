class RangeHeaderParseException implements Exception {
  final String message;

  RangeHeaderParseException(this.message);

  @override
  String toString() => 'Range header parse exception: $message';
}