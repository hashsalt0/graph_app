
import '../../utils/logger.dart';
import 'menu.dart';
import 'field.dart';
import 'single_value_field.dart';

/// An entry is the type of menu that accepts values.
/// It has a [Map] of [Field] that contains [SingleValueField]
/// It accepts till all the values of [Field] are accepted.

class Entry extends Menu {
  Entry(String name) : super(name);

  final Map<String, Field> fields = {};

  /// add a [Field] that reads a value from command line when menu is executed
  void addField<T>(Field<T> newField) {
    fields.putIfAbsent(newField.name, () => newField);
  }

  /// Reading all the [Field]  in [fields]
  @override
  void execute() {
    Log.info("");
    Log.help(name);
    Log.info("");
    for (var field in fields.values) {
      field.readValue();
    }
  }
}
