import '../../exceptions/invalid_choice_exception.dart';
import '../../utils/input.dart';
import '../../utils/logger.dart';
import '../../utils/string_values.dart';
import '../../utils/utils.dart';
import 'menu.dart';

/// Type of [Menu] that has a list of sub menus and it accepts a choice to be  
/// entered in the command line. ie a natural number. Based upon which subsequent
/// submenu will be executed. 

class Choice extends Menu {
  final List<Menu> _subMenus = [];

  Choice(String name) : super(name);

  /// Function to display all the sub menus.
  void _displayMenu() {
    _subMenus.asMap().forEach((index, value) {
      Log.info("${index + 1}. ${value.name}");
    });
  }

  /// adds a sub menu
  void addMenu(Menu menu) {
    _subMenus.add(menu);
  }

  /// Reads an integer value until it is passes validation.
  int _readChoice() {
    Log.info("Enter choice less than ${_subMenus.length + 1} :: ");
    String? _value = Input.readLine() ?? StringValues.unknownValue;
    int? choice = int.tryParse(_value);
    // validate choice
    if (choice == null || choice <= 0 || choice > _subMenus.length) {
      throw InvalidChoiceException("read $_value");
    }
    return choice;
  }

  @override
  void execute() {
    _displayMenu();
    // reading the choice and executing it.
    while(Utils.catchError(_readAndExecute) == false) {}
  }

  void _readAndExecute(){
    int choice = _readChoice();
    _subMenus[choice - 1].execute();
  }
}
