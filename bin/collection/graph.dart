import 'dart:collection';

import '../exceptions/cyclic_graph_exception.dart';
import '../exceptions/duplicate_depedency_exception.dart';
import '../exceptions/duplicate_node_exception.dart';
import '../exceptions/node_not_found_exception.dart';
import 'node.dart';

class Graph {
  final HashSet<Node> _nodes = HashSet();

  Node getNodeWithId(int id) {
    Node? node = _nodes.lookup(Node(id: id));
    if (node == null) throw NodeNotFoundException("Node with id $id is not present in the graph");
    return node;
  }

  void addNode({required int id, String? name}) {
    Node node = Node(id: id, name: name ?? "");
    if (_nodes.contains(node)) throw DuplicateNodeException("Node with id $id is already present in the graph");
    _nodes.add(node);
  }

  void addDepedency({required int parentId, required int childId}) {
    Node childNode = getNodeWithId(childId);
    Node parentNode = getNodeWithId(parentId);
    if (childNode.getDescendantNodes().contains(parentNode) == true) {
      throw CyclicGraphException("path from child node $childId to parent node $parentId exists");
    }
    if (parentNode.getAncestorNodes().contains(childNode) == true) {
      throw CyclicGraphException("path from parent node $parentId to child node $childId exists");
    }

    if(childNode.parent.contains(parentNode)) throw DuplicateDepedencyException("$parentId has already a node child with id $childId ");

    childNode.parent.add(parentNode);
    parentNode.children.add(childNode);
  }

  void removeDepedency({required int parentId, required int childId}) {
    Node childNode = getNodeWithId(childId);
    Node parentNode = getNodeWithId(parentId);
    childNode.parent.remove(parentNode);
    parentNode.children.remove(childNode);
  }

  void deleteNode(int id) {
    Node node = getNodeWithId(id);
    node.disconnectFromParent();
    _disconnectFromChildren(node);
    _nodes.remove(node);
  }

  void _disconnectFromChildren(Node node) {
    Iterable<Node> children = node.children.toList();
    for (Node child in children) {
      removeDepedency(parentId: node.nodeId, childId: child.nodeId);
    }
  }
}
