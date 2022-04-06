import 'graph_app_exception.dart';

/// Exception to be thrown when a Node(vertex) is not found in the
/// graph
class NodeNotFoundException extends GraphAppException {
  NodeNotFoundException(cause) : super("Node is not found in the graph", cause);
}
