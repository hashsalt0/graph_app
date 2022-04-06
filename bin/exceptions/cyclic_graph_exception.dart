import '../utils/strings.dart';
import 'graph_app_exception.dart';

/// Exception to be thrown when a cycle in the graph has been detected 
class CyclicGraphException extends GraphAppException {
  CyclicGraphException(String cause) : super(Strings.cyclicGraphExceptionMessage, cause);
}
