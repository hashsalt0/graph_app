import 'dart:convert';
import 'dart:io';

/// Input class helpful for debugging purposes
class Input {
  static String? Function()? mock;

  static String? readLine() {
    return _readFunction();
  }

  static String? Function() get _readFunction =>
      mock ??
      () {
        return stdin.readLineSync(encoding: utf8);
      };
}
