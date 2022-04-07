/// Represents a menu type
/// Menu can represent a collection of feild or more sub menus or an action.
/// It is based on command design patten.

abstract class Menu {
  final String name;

  /// [name] of the menu that is printed on the command line.
  Menu(this.name);

  ///  this function is where all the menu operations are defined.
  void execute();
}
