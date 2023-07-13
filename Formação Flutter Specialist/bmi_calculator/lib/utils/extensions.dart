extension StringExtensions on String {
  String get asNeutral => '\x1B[38;5;33m$this\x1B[0m';
  String get asSuccess => '\x1B[38;5;10m$this\x1B[0m';
  String get asWarning => '\x1B[38;5;3m$this\x1B[0m';
  String get asAlert => '\x1B[38;5;172m$this\x1B[0m';
  String get asDanger => '\x1B[38;5;9m$this\x1B[0m';
}
