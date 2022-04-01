import 'graph_app_exception.dart';

class NodeNotFoundException extends GraphAppException {
  NodeNotFoundException(cause) : super("Node is not found in the graph", cause);
}
