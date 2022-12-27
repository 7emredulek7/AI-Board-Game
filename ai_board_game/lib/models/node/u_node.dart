import '../node/node.dart';

class UNode extends Node {
  UNode(
      {required super.board,
      required super.cost,
      required super.goalBoard,
      required super.level,
      super.prevNode});
}
