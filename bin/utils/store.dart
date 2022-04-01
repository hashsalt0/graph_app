import '../collection/graph.dart';

class Store {
  // Flag to state weather the application is running or not.
  bool isRunning = true;

  final Graph graph = Graph();

  Store._();

  static final Store _instance = Store._();

  static Store get instance {
    return _instance;
  }
}
