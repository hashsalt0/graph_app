import 'graph_app_exception.dart';

class CyclicGraphException extends GraphAppException {
  CyclicGraphException(String cause) : super("Graph is cyclic", cause);
}
