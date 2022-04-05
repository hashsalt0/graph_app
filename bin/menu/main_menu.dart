import '../collection/node.dart';
import '../utils/const.dart';
import '../utils/logger.dart';
import '../utils/store.dart';
import 'base/choice.dart';
import 'base/entry.dart';
import 'base/menu.dart';

class MainMenu extends Choice {
  MainMenu() : super('') {
    addMenu(_NodeOperationMenu(
        name: "Get the immediate parents of a node",
        operation: (Node n) => _printNodes("Immediate parents", n.parent, n.nodeId)));
    addMenu(_NodeOperationMenu(
        name: "Get the immediate children of a node",
        operation: (Node n) => _printNodes("Immediate children", n.children, n.nodeId)));
    addMenu(_NodeOperationMenu(
        name: "Get the ancestors of a node",
        operation: (Node n) => _printNodes("Ancestors", n.getAncestorNodes(), n.nodeId)));
    addMenu(_NodeOperationMenu(
        name: "Get the descendants of a node",
        operation: (Node n) => _printNodes("Descendants", n.getDescendantNodes(), n.nodeId)));
    addMenu(_ParentChildOperationMenu(
        name: "Delete dependency from a tree",
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.removeDepedency(parentId: parentId, childId: childId);
          Log.info(
              "Removed dependency from parent $parentId to child $childId");
        }));
    addMenu(_NodeOperationMenu(
        name: "Delete a node from a tree",
        operation: (Node n) {
          Store.instance.graph.deleteNode(n.nodeId);
          Log.info("Deleted node with id ${n.nodeId}");
        }));
    addMenu(_ParentChildOperationMenu(
        name: "Add a new dependency to a tree",
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.addDepedency(parentId: parentId, childId: childId);
          Log.info(
              "Added a dependency from parent $parentId to child $childId");
        }));
    addMenu(_AddNodeMenu());
    addMenu(_ExitMenu());
  }

  void _printNodes(String message, Set<Node> nodes, int nodeId){
    Log.help("$message of the node with id $nodeId are -");
    Log.info(nodes);
  }
}

class _ExitMenu extends Menu{
  _ExitMenu() : super("Exit");

  @override
  void execute() {
    Store.instance.isRunning = false;
    Log.help("Exiting Application...");
  }

}

class _AddNodeMenu extends Entry{
  _AddNodeMenu() : super("Add a new node to tree"){
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
  final void Function(Node node) _operation;

  _NodeOperationMenu(
      {required String name,
      required void Function(Node node) operation})
      : _operation = operation,
        super(name) {
    addField(Const.nodeIdField);
  }

  @override
  void execute() {
    super.execute();
    int nodeId = fields[Const.nodeIdSerial]?.value as int;
    _operation(Store.instance.graph.getNodeWithId(nodeId));
  }
}

class _ParentChildOperationMenu extends Entry {
  final void Function({required int parentId, required int childId}) _operation;

  _ParentChildOperationMenu(
      {required String name,
      required void Function({required int parentId, required int childId})
          operation})
      : _operation = operation,
        super(name) {
    addField(Const.parentIdField);
    addField(Const.childIdField);
  }

  @override
  void execute() {
    super.execute();
    int parentId = fields[Const.parentIdSerial]?.value as int;
    int childId = fields[Const.childIdSerial]?.value as int;
    _operation(parentId: parentId, childId: childId);
  }
}
