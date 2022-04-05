/// Base Exception Class for the current application
abstract class GraphAppException implements Exception{
  final String cause;
  final String message;

  GraphAppException(this.message, this.cause);
}