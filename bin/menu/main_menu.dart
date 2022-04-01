import '../collection/node.dart';
import '../utils/const.dart';
import '../utils/logger.dart';
import '../utils/store.dart';
import 'base/choice.dart';
import 'base/entry.dart';
import 'base/menu.dart';

class MainMenu extends Choice {
  MainMenu() : super('') {
    addMenu(NodeOperationMenu(
        name: "Get the immediate parents of a node",
        operation: (Node n) => _printNodes("Immediate parents", n.parent, n.nodeId)));
    addMenu(NodeOperationMenu(
        name: "Get the immediate children of a node",
        operation: (Node n) => _printNodes("Immediate children", n.children, n.nodeId)));
    addMenu(NodeOperationMenu(
        name: "Get the ancestors of a node",
        operation: (Node n) => _printNodes("Ancestors", n.getAncestorNodes(), n.nodeId)));
    addMenu(NodeOperationMenu(
        name: "Get the descendants of a node",
        operation: (Node n) => _printNodes("Descendants", n.getDescendantNodes(), n.nodeId)));
    addMenu(ParentChildOperationMenu(
        name: "Delete dependency from a tree",
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.removeDepedency(parentId: parentId, childId: childId);
          Log.info(
              "Removed dependency from parent $parentId to child $childId");
        }));
    addMenu(NodeOperationMenu(
        name: "Delete a node from a tree",
        operation: (Node n) {
          Store.instance.graph.deleteNode(n.nodeId);
          Log.info("Deleted node with id ${n.nodeId}");
        }));
    addMenu(ParentChildOperationMenu(
        name: "Add a new dependency to a tree",
        operation: ({required int parentId, required int childId}) {
          Store.instance.graph.addDepedency(parentId: parentId, childId: childId);
          Log.info(
              "Added a dependency from parent $parentId to child $childId");
        }));
    addMenu(AddNodeMenu());
    addMenu(ExitMenu());
  }

  void _printNodes(String message, Set<Node> nodes, int nodeId){
    Log.help("$message of the node with id $nodeId are -");
    Log.info(nodes);
  }
}

class ExitMenu extends Menu{
  ExitMenu() : super("Exit");

  @override
  void execute() {
    Store.instance.isRunning = false;
    Log.help("Exiting Application...");
  }

}

class AddNodeMenu extends Entry{
  AddNodeMenu() : super("Add a new node to tree"){
    addField(Const.nodeIdField);
    addField(Const.nodeNameField);
  }

  @override
  void execute() {
    super.execute();
    int id = fields[Const.nodeIdSerial]?.value as int;
    String name = fields[Const.nodeNameSerial]?.value as String;
    Store.instance.graph.addNode(id: id, name: name);
  }
}


class NodeOperationMenu extends Entry {
  final void Function(Node node) _operation;

  NodeOperationMenu(
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

class ParentChildOperationMenu extends Entry {
  final void Function({required int parentId, required int childId}) _operation;

  ParentChildOperationMenu(
      {required String name,
      required void Function({required int parentId, required int childId})
          operation})
      : _operation = operation,
        super(name) {
    addField(Const.childIdField);
    addField(Const.parentIdField);
  }

  @override
  void execute() {
    super.execute();
    int childId = fields[Const.parentIdSerial]?.value as int;
    int parentId = fields[Const.childIdSerial]?.value as int;
    _operation(parentId: parentId, childId: childId);
  }
}
