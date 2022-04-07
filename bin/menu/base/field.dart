


abstract class Field<T> {
  final String name;
  // can be protected but no option in dart
  final String message;

  late T? value;

  Field({required this.name, required this.message});

  T? readValue();
}
