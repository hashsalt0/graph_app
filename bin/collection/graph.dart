import 'dart:collection';

import '../exceptions/cyclic_graph_exception.dart';
import '../exceptions/depedency_not_found.dart';
import '../exceptions/duplicate_depedency_exception.dart';
import '../exceptions/duplicate_node_exception.dart';
import '../exceptions/node_not_found_exception.dart';
import 'node.dart';

class Graph {
  final HashSet<Node> _nodes = HashSet();

  /// Find the node with specified id in the graph
  /// thows [NodeNotFoundException] when the node is not found
  Node getNodeWithId(int id) {
    Node? node = _nodes.lookup(Node(id: id));
    if (node == null) throw NodeNotFoundException("Node with id $id is not present in the graph");
    return node;
  }

  /// Adds a node to the graph 
  /// params [id] Id of the node
  /// params [name] Name of the node
  /// thows [DuplicateNodeException] when node with same id is present in the graph
  void addNode({required int id, String? name}) {
    Node node = Node(id: id, name: name ?? "");
    if (_nodes.contains(node)) throw DuplicateNodeException("Node with id $id is already present in the graph");
    _nodes.add(node);
  }

  /// Adds a Depedency(Edge) to the graph between two nodes (parent to child)
  /// params [parentId] Id of the parent node
  /// params [childId] Id of the child node
  /// thows [CyclicGraphException] when adding an edge makes a cycle in the graph
  /// hence ignoring the Depedency
  void addDepedency({required int parentId, required int childId}) {
    Node childNode = getNodeWithId(childId);
    Node parentNode = getNodeWithId(parentId);
    /// We can go from child to parent
    if (childNode.getDescendantNodes().contains(parentNode) == true) {
      throw CyclicGraphException("path from child node $childId to parent node $parentId exists");
    }
    
    /// We can go from parent to child
    if (parentNode.getAncestorNodes().contains(childNode) == true) {
      throw CyclicGraphException("path from parent node $parentId to child node $childId exists");
    }

    if(childNode.parent.contains(parentNode)) throw DuplicateDepedencyException("$parentId has already a node child with id $childId ");

    childNode.parent.add(parentNode);
    parentNode.children.add(childNode);
  }

  
  /// Adds a Depedency(Edge) to the graph between two nodes (parent to child)
  /// params [parentId] Id of the parent node
  /// params [childId] Id of the child node
  /// throws [DepedencyNotFound] when there is no edge in between parent and child node
  void removeDepedency({required int parentId, required int childId}) {
    Node childNode = getNodeWithId(childId);
    Node parentNode = getNodeWithId(parentId);

    if(childNode.parent.contains(parentNode) == false && parentNode.children.contains(childNode) == false) {
      throw DepedencyNotFound("There is no Depedency in b/w $childId and $parentNode");
    }
    childNode.parent.remove(parentNode);
    parentNode.children.remove(childNode);
  }

  /// Deletes the node have id [id] 
  void deleteNode(int id) {
    Node node = getNodeWithId(id);
    // remove self from all the parents
    node.disconnectFromParent();
    // remove the node from all its children
    _disconnectFromChildren(node);
    // deletes the node from the graph set.
    _nodes.remove(node);
  }

  /// detaches [node] from all its children. 
  void _disconnectFromChildren(Node node) {
    Iterable<Node> children = node.children.toList();
    for (Node child in children) {
      removeDepedency(parentId: node.nodeId, childId: child.nodeId);
    }
  }
}
