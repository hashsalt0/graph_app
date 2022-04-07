import '../exceptions/cast_exception.dart';
import '../exceptions/graph_app_exception.dart';
import 'logger.dart';
import 'strings.dart';

class Utils {
  static String castToString(String? text) => text.toString();

  static bool catchError(Function block) {
    try {
      block();
      return true;
    } on GraphAppException catch (e, stackTrace) {
      Log.help(e.message);
      Log.help("because ${e.cause}");
      Log.debug(e);
      Log.debug(stackTrace);
    } catch (e, stackTrace) {
      Log.debug(e);
      Log.debug(stackTrace);
    }
    return false;
  }

  static int castToInt(String? text) {
    try {
      return int.parse(text ?? "");
    } catch (e) {
      throw CastException(Strings.invalidInteger);
    }
  }

}
