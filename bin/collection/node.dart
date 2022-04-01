import 'dart:collection';

class Node implements Comparable {
  final int nodeId;
  final String nodeName;

  final HashSet<Node> children = HashSet();
  final HashSet<Node> parent = HashSet();

  Node({required id, name = ""})
      : nodeId = id,
        nodeName = name;

  Set<Node> getAncestorNodes() {
    HashSet<Node> ancestor = HashSet();
    ancestor.addAll(parent);
    for (var node in parent) {
      ancestor.addAll(node.getAncestorNodes());
    }
    return ancestor;
  }

  Set<Node> getDescendantNodes() {
    HashSet<Node> descendant = HashSet();
    descendant.addAll(children);
    for (var node in children) {
      descendant.addAll(node.getDescendantNodes());
    }
    return descendant;
  }

  bool hasChildWithId(int childId) {
    return children.contains(Node(id: childId));
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

  void disconnectFromParent() {
    for (Node node in parent) {
      node.children.remove(this);
    }
  }
}
