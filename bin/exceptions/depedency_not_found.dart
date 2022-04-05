import 'graph_app_exception.dart';

class DepedencyNotFound extends GraphAppException {
  DepedencyNotFound(String cause) : super("No Depedency Found", cause);
}