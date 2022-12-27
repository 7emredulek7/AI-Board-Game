import '../models/node/node.dart';

class SearchingResult {
  Node? result;
  List<Node> expandedNodes;
  List<Node> fringe;

  SearchingResult(
      {required this.result,
      required this.expandedNodes,
      required this.fringe});
}
