import '../utils/strings.dart';
import 'graph_app_exception.dart';

/// Type of [GraphAppException] thrown when user enters a value that cannont
/// be converted to a type.

class CastException extends GraphAppException {
  CastException(cause) : super(Strings.castExceptionMessage, cause);
}
