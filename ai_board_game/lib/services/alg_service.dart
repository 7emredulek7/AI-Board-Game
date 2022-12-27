import 'dart:math';

import '../models/node/a_node.dart';
import '../models/node/node.dart';
import '../models/node/u_node.dart';
import '../models/searching_result.dart';
import '../models/tile/tile.dart';
import 'package:collection/collection.dart';

class AlgService {
  Future<SearchingResult> uniformCostSearch(List<List<Tile?>> initialBoard,
      List<List<Tile?>> goalBoard, List<Tile> order) async {
    return await Future(
      () {
        Node initNode =
            UNode(board: initialBoard, cost: 0, goalBoard: goalBoard, level: 3);

        List<Node> fringe = [];
        fringe.add(initNode);

        List<Node> visited = [];
        List<Node> expandedNodes = [];

        while (fringe.isNotEmpty && expandedNodes.length < 10) {
          Node node = removeMinCostNode(fringe);

          if (isBoardsEqual(node.board, goalBoard)) {
            expandedNodes.add(node);
            return SearchingResult(
                result: node, expandedNodes: expandedNodes, fringe: fringe);
          }

          if (containsNode(visited, node)) continue;

          visited.add(node);
          expandedNodes.add(node);

          List<Node> neighbours = node.getNeighbours(order[node.level % 3], 1);

          for (Node neighbour in neighbours) {
            if (fringe.length > 25) {
              removeMaxCostNode(fringe);
            }
            fringe.add(neighbour);
          }
        }

        return SearchingResult(
          result: null,
          expandedNodes: expandedNodes,
          fringe: fringe,
        );
      },
    );
  }

  Future<SearchingResult> aStarSearch(List<List<Tile?>> initialBoard,
      List<List<Tile?>> goalBoard, List<Tile> order) async {
    SearchingResult result = await Future(
      () {
        Node initNode = ANode(
            board: Node.copyBoard(initialBoard),
            cost: 0,
            goalBoard: Node.copyBoard(goalBoard),
            level: 3);

        List<Node> fringe = [];
        fringe.add(initNode);

        List<Node> visited = [];
        List<Node> expandedNodes = [];

        while (fringe.isNotEmpty && expandedNodes.length < 10) {
          Node node = removeMinCostNode(fringe);

          if (isBoardsEqual(node.board, goalBoard)) {
            expandedNodes.add(node);
            return SearchingResult(
                result: node, expandedNodes: expandedNodes, fringe: fringe);
          }

          if (containsNode(visited, node)) {
            continue;
          }

          visited.add(node);
          expandedNodes.add(node);

          List<Node> neighbours = node.getNeighbours(order[node.level % 3], 2);

          for (Node neighbour in neighbours) {
            if (fringe.length > 25) {
              removeMaxCostNode(fringe);
            }
            fringe.add(neighbour);
          }
        }

        return SearchingResult(
          result: null,
          expandedNodes: expandedNodes,
          fringe: fringe,
        );
      },
    );

    return result;
  }

  // ----- Helper Functions -----

  Node removeMinCostNode(List<Node> nodes) {
    int minCostNodeIndex = 0;

    for (int i = 0; i < nodes.length; i++) {
      if (Node.isLowerThan(nodes[i], nodes[minCostNodeIndex])) {
        minCostNodeIndex = i;
      }
    }

    Node n = nodes.removeAt(minCostNodeIndex);
    return n;
  }

  Node removeMaxCostNode(List<Node> nodes) {
    int maxCostNodeIndex = 0;

    for (int i = 0; i < nodes.length; i++) {
      if (Node.isGreaterThan(nodes[i], nodes[maxCostNodeIndex])) {
        maxCostNodeIndex = i;
      }
    }

    Node n = nodes.removeAt(maxCostNodeIndex);
    return n;
  }

  bool isBoardsEqual(List<List<Tile?>> board1, List<List<Tile?>> board2) {
    Function deepEq = const DeepCollectionEquality().equals;

    return deepEq(board1, board2);
  }

  bool containsNode(List<Node> nodes, Node n) {
    bool contains = false;

    for (Node node in nodes) {
      if (isBoardsEqual(node.board, n.board)) {
        contains = true;
        return contains;
      }
    }

    return contains;
  }
}
