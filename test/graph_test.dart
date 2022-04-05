
import 'dart:collection';

import 'package:test/test.dart';

import '../bin/collection/graph.dart';
import '../bin/collection/node.dart';

void main() {
  test("Test graph is correct", () {
    Graph graph = Graph();
    graph.addNode(id: 1);
    graph.addNode(id: 2);
    graph.addNode(id: 3);
    graph.addNode(id: 4);
    graph.addNode(id: 5);
    graph.addNode(id: 6);
    graph.addNode(id: 7);
    expect(() => graph.addNode(id: 3), throwsException);
    graph.addDepedency(parentId: 1, childId: 2);
    graph.addDepedency(parentId: 1, childId: 3);
    graph.addDepedency(parentId: 2, childId: 4);
    graph.addDepedency(parentId: 3, childId: 4);
    graph.addDepedency(parentId: 4, childId: 5);
    graph.addDepedency(parentId: 4, childId: 6);
    graph.addDepedency(parentId: 6, childId: 7);
    graph.addDepedency(parentId: 5, childId: 7);
    graph.deleteNode(3);
    expect(() => graph.getNodeWithId(3), throwsException);
    
    expect(graph.getNodeWithId(4) == Node(id: 4), true);
    expect(equalSet(graph.getNodeWithId(4).getAncestorNodes(), {Node(id: 2), Node(id: 1)}), true);
    expect(graph.getNodeWithId(5) == Node(id: 5), true);
    expect(graph.getNodeWithId(6) == Node(id: 6), true);
    expect(graph.getNodeWithId(2) == Node(id: 2), true);
    expect(graph.getNodeWithId(1) == Node(id: 1), true);
    expect(graph.getNodeWithId(7) == Node(id: 7), true);
    graph.deleteNode(4);
    expect(equalSet(graph.getNodeWithId(1).getDescendantNodes(), {Node(id: 2)}),
        true);
    expect(equalSet(graph.getNodeWithId(6).getDescendantNodes(), {Node(id: 7)}),
        true);
    expect(equalSet(graph.getNodeWithId(5).getDescendantNodes(), {Node(id: 7)}),
        true);
    graph.removeDepedency(parentId: 5, childId: 7);
    expect(equalSet(graph.getNodeWithId(5).getDescendantNodes(), <dynamic>{}),
        true);
  });
}

bool equalSet(var set1, var set2) {
  // check if both are sets
  if (!(set1 is Set && set2 is Set)
      // check if both have same length
      ||
      set1.length != set2.length) {
    return false;
  }
  Set ans = set1.difference(set2);
  return ans.isEmpty == true;
}
