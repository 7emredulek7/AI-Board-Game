import 'node.dart';

class ANode extends Node {
  ANode(
      {required super.board,
      required super.cost,
      required super.goalBoard,
      required super.level,
      super.prevNode}) {
    heuristic = _hammingDistance();
  }

  int _hammingDistance() {
    int distance = 0;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if ((board[i][j] != null) && (board[i][j] != goalBoard[i][j])) {
          distance++;
        }
      }
    }

    return distance;
  }
}
