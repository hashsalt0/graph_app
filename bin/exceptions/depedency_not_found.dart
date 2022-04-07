import '../utils/strings.dart';
import 'graph_app_exception.dart';

class DepedencyNotFoundException extends GraphAppException {
  DepedencyNotFoundException(String cause) : super(Strings.depedencyNotFoundExceptionMessage, cause);
}