import 'package:flutter/foundation.dart';
import '../locator.dart';
import '../models/node/node.dart';
import '../models/searching_result.dart';
import '../models/tile/tile.dart';
import '../services/alg_service.dart';

class SearchingViewModel with ChangeNotifier {
  final _algService = locator<AlgService>();

  SearchingResult? searchingResult;
  bool _isLoading = false;

  Future<void> startSearching(
    int algorithmNumber,
    List<List<Tile?>> initBoard,
    List<List<Tile?>> goalBoard,
    List<Tile> order,
  ) async {
    isLoading = true;

    if (algorithmNumber == 1) {
      searchingResult =
          await _algService.uniformCostSearch(initBoard, goalBoard, order);
    } else if (algorithmNumber == 2) {
      searchingResult =
          await _algService.aStarSearch(initBoard, goalBoard, order);
    }

    isLoading = false;
  }

  bool get isLoading => _isLoading;

  List<Node> solutionWithSteps() {
    List<Node> steps = [];

    if (searchingResult != null && searchingResult!.result != null) {
      Node? node = searchingResult!.result!;

      steps.add(node);

      while (node!.prevNode != null) {
        steps.add(node.prevNode!);
        node = node.prevNode;
      }

      steps = steps.reversed.toList();
    }

    return steps;
  }

  int solutionStepsCount() {
    int steps = 0;

    if (searchingResult != null && searchingResult!.result != null) {
      Node? node = searchingResult!.result!;

      while (node.prevNode != null) {
        steps++;
      }
    }
    return steps;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
