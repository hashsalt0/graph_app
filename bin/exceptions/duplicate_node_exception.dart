import 'graph_app_exception.dart';


/// Exception to be thrown when a Node(vertex) is added while it is
/// already present in graph
class DuplicateNodeException extends GraphAppException {
  DuplicateNodeException(String cause) : super("Node is already present in the graph", cause);
} 