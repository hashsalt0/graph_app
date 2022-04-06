import '../../utils/input.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import 'field.dart';
import 'entry.dart';

/// A Type of [Field] for [Entry] classes. It accepts a [T] value.

class SingleValueField<T> extends Field<T> {

  /// Single value field default valdiation is none ie. accepts any value 
  SingleValueField({required String name, required String message, required this.cast })
      :super(name: name, message: message);

  /// validate function (not necessary to provide)

  /// cast function for converting the string read to [T] (not necessary to provide)
  final T? Function(String? recivedValue) cast;

  /// Reads a [T] value and return a [T]?. The returned value is guaranteed to
  /// be a [T] type. As it read till it recives the correct value.
  @override
  T? readValue() {
    Log.info("$message :: ");
    String? line = Input.readLine();
    if (!_validateTry(line)) return readValue();
    return value = cast(line);
  }

  bool _validateTry(String? line) {
    return Utils.catchError(() => cast(line));
  }
}
