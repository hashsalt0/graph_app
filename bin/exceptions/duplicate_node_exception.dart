import 'graph_app_exception.dart';

class DuplicateNodeException extends GraphAppException {
  DuplicateNodeException(String cause) : super("Node is already present in the graph", cause);
  
} 