import 'graph_app_exception.dart';

class DuplicateDepedencyException extends GraphAppException {
  DuplicateDepedencyException(String cause) : super("Graph is cyclic", cause);
}