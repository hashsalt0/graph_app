import 'dart:io';

import 'menu/main_menu.dart';
import 'utils/logger.dart';
import 'utils/store.dart';
import 'utils/utils.dart';

class GraphAppRunnable {
  GraphAppRunnable();

  /// executes the main menu indefinitely
  void run() {
    while (Store.instance.isRunning) {
      Utils.catchError(() {
        Log.help("\n"+"-"*stdout.terminalColumns+"\n");
        MainMenu mainMenu = MainMenu();
        mainMenu.execute();
      });
    }
  }
}
