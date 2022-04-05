import 'graph_app_exception.dart';

/// Exception to be thrown when a Depedency(edge) is added while it is
/// already present in graph
class DuplicateDepedencyException extends GraphAppException {
  DuplicateDepedencyException(String cause) : super("Duplicate Depedency Found", cause);
}