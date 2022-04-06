import 'dart:collection';

class Node implements Comparable {
  final int nodeId;
  final String nodeName;
  
  /// set of children nodes
  final HashSet<Node> children = HashSet();
  
  /// set of parents nodes
  final HashSet<Node> parent = HashSet();

  Node({required id, name = ""})
      : nodeId = id,
        nodeName = name;

  /// Returns [Set] of [Node] that are Ancestors of this.
  Set<Node> getAncestorNodes() {
    HashSet<Node> ancestor = HashSet();
    ancestor.addAll(parent);
    for (var node in parent) {
      ancestor.addAll(node.getAncestorNodes());
    }
    return ancestor;
  }


  /// Returns [Set] of [Node] that are Descendant of this.
  Set<Node> getDescendantNodes() {
    HashSet<Node> descendant = HashSet();
    descendant.addAll(children);
    for (var node in children) {
      descendant.addAll(node.getDescendantNodes());
    }
    return descendant;
  }

  @override
  String toString(){
    return "Node Id: $nodeId, Name: $nodeName";
  }

  @override
  int compareTo(other) {
    if (other is Node) {
      return nodeId.compareTo(other.nodeId);
    }
    return -1;
  }

  @override
  int get hashCode => nodeId.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Node && nodeId == other.nodeId;
  }

  /// Detaches this from all the parent by removing all the refrences from parent
  void disconnectFromParent() {
    for (Node node in parent) {
      node.children.remove(this);
    }
  }
}
