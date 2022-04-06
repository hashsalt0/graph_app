import '../utils/strings.dart';
import 'graph_app_exception.dart';
import '../menu/base/choice.dart';

/// Type of [GraphAppException] thrown when user enters an Invalid choice from the
/// [Choice] menu.

class InvalidChoiceException extends GraphAppException {
  InvalidChoiceException(cause)
      : super(Strings.invalidChoiceExceptionMessage, cause);
}
