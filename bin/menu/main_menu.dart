import '../collection/node.dart';
import '../utils/const.dart';
import '../utils/logger.dart';
import '../utils/store.dart';
import '../utils/strings.dart';
import 'base/choice.dart';
import 'base/entry.dart';
import 'base/menu.dart';

class MainMenu extends Choice {
  static final _menus = [_NodeOperationMenu(
        name: Strings.menuOptParents,
        operation: (Node n) => _printNodes("Immediate parents", n.parent, n.nodeId)),
        _NodeOperationMenu(
        name: Strings.menuOptChildrens,
        operation: (Node n) => _printNodes("Immediate children", n.children, n.nodeId)),
        _NodeOperationMenu(
        name: Strings.menuOptAncestors,
        operation: (Node n) => _printNodes("Ancestors", n.getAncestorNodes(), n.nodeId)),
        _NodeOperationMenu(
        name: Strings.menuOptDescendants,
        operation: (Node n) => _printNodes("Descendants", n.getDescendantNodes(), n.nodeId)),
        _ParentChildOperationMenu(
        name: Strings.menuOptDeleteDependency,
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.removeDepedency(parentId: parentId, childId: childId);
          Log.info(
              "Removed dependency from parent $parentId to child $childId");
        }),
        _NodeOperationMenu(
        name: Strings.menuOptDeleteNode,
        operation: (Node n) {
          Store.instance.graph.deleteNode(n.nodeId);
          Log.info("Deleted node with id ${n.nodeId}");
        }),
        _ParentChildOperationMenu(
        name: Strings.menuOptAddDependency,
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.addDepedency(parentId: parentId, childId: childId);
          Log.info("Added a dependency from parent $parentId to child $childId");
        }),
        _AddNodeMenu(),
        _ExitMenu()
  ];

  MainMenu() : super(Strings.appName) {
    _initializeMenus();
  }

  void _initializeMenus(){
    _menus.forEach(addMenu);
  }

  static void _printNodes(String message, Set<Node> nodes, int nodeId){
    Log.help("$message of the node with id $nodeId are -");
    Log.info(nodes);
  }
}

class _ExitMenu extends Menu{
  _ExitMenu() : super(Strings.menuOptExit);

  @override
  void execute() {
    Store.instance.isRunning = false;
    Log.help("Exiting Application...");
  }

}

class _AddNodeMenu extends Entry{
  _AddNodeMenu() : super(Strings.menuOptAddNode){
    addField(Const.nodeIdField);
    addField(Const.nodeNameField);
  }

  @override
  void execute() {
    super.execute();
    int id = fields[Const.nodeIdSerial]?.value as int;
    String name = fields[Const.nodeNameSerial]?.value as String;
    Store.instance.graph.addNode(id: id, name: name);
    Log.help("Sucessfully added node to the grap. ${Store.instance.graph.getNodeWithId(id)}");
  }
}


class _NodeOperationMenu extends Entry {
  final void Function(Node node) operation;

  _NodeOperationMenu(
      {required String name,
      required this.operation})
      : super(name) {
    addField(Const.nodeIdField);
  }

  @override
  void execute() {
    super.execute();
    int nodeId = fields[Const.nodeIdSerial]?.value as int;
    operation(Store.instance.graph.getNodeWithId(nodeId));
  }
}

class _ParentChildOperationMenu extends Entry {
  final void Function({required int parentId, required int childId}) operation;

  _ParentChildOperationMenu(
      {required String name,
      required this.operation})
      : super(name) {
    addField(Const.parentIdField);
    addField(Const.childIdField);
  }

  @override
  void execute() {
    super.execute();
    int parentId = fields[Const.parentIdSerial]?.value as int;
    int childId = fields[Const.childIdSerial]?.value as int;
    operation(parentId: parentId, childId: childId);
  }
}
