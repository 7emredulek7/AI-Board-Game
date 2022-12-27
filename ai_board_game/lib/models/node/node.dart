import '../tile/tile.dart';
import 'a_node.dart';
import 'u_node.dart';

abstract class Node {
  List<List<Tile?>> board;
  int cost;
  List<List<Tile?>> goalBoard;
  int level;
  Node? prevNode;

  int? heuristic;

  Node({
    required this.board,
    required this.cost,
    required this.level,
    required this.goalBoard,
    this.prevNode,
  });

  List<Node> getNeighbours(Tile tile, int algorithmNumber) {
    List<Node> neighbours = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] != null && board[i][j]!.color == tile.color) {
          int tempLevel = level + 1;

          // Try moving a tile to the left
          if (j > 0) {
            List<List<Tile?>> newBoard = copyBoard(board);

            if (newBoard[i][j - 1] == null) {
              newBoard[i][j] = null;
              newBoard[i][j - 1] = tile;

              int moveCost = tile.moveCost('left');

              goalBoard = copyBoard(goalBoard);

              if (moveCost != 0) {
                if (algorithmNumber == 1) {
                  neighbours.add(
                    UNode(
                      board: newBoard,
                      cost: cost + moveCost,
                      goalBoard: goalBoard,
                      level: tempLevel,
                      prevNode: this,
                    ),
                  );
                } else if (algorithmNumber == 2) {
                  neighbours.add(
                    ANode(
                        board: newBoard,
                        cost: cost + moveCost,
                        goalBoard: goalBoard,
                        level: tempLevel,
                        prevNode: this),
                  );
                }
              }
            }
          }

          // Try moving a tile to the right
          if (j < 2) {
            List<List<Tile?>> newBoard = copyBoard(board);

            if (newBoard[i][j + 1] == null) {
              newBoard[i][j] = null;
              newBoard[i][j + 1] = tile;

              int moveCost = tile.moveCost('right');

              goalBoard = copyBoard(goalBoard);

              if (moveCost != 0) {
                if (algorithmNumber == 1) {
                  neighbours.add(
                    UNode(
                      board: newBoard,
                      cost: cost + moveCost,
                      goalBoard: goalBoard,
                      level: tempLevel,
                      prevNode: this,
                    ),
                  );
                } else if (algorithmNumber == 2) {
                  neighbours.add(
                    ANode(
                        board: newBoard,
                        cost: cost + moveCost,
                        goalBoard: goalBoard,
                        level: tempLevel,
                        prevNode: this),
                  );
                }
              }
            }
          }

          // Try moving a tile up
          if (i > 0) {
            List<List<Tile?>> newBoard = copyBoard(board);

            if (newBoard[i - 1][j] == null) {
              newBoard[i][j] = null;
              newBoard[i - 1][j] = tile;

              int moveCost = tile.moveCost('up');

              goalBoard = copyBoard(goalBoard);

              if (moveCost != 0) {
                if (algorithmNumber == 1) {
                  neighbours.add(
                    UNode(
                      board: newBoard,
                      cost: cost + moveCost,
                      goalBoard: goalBoard,
                      level: tempLevel,
                      prevNode: this,
                    ),
                  );
                } else if (algorithmNumber == 2) {
                  neighbours.add(
                    ANode(
                        board: newBoard,
                        cost: cost + moveCost,
                        goalBoard: goalBoard,
                        level: tempLevel,
                        prevNode: this),
                  );
                }
              }
            }
          }

          // Try moving a tile down
          if (i < 2) {
            List<List<Tile?>> newBoard = copyBoard(board);

            if (newBoard[i + 1][j] == null) {
              newBoard[i][j] = null;
              newBoard[i + 1][j] = tile;

              int moveCost = tile.moveCost('down');

              goalBoard = copyBoard(goalBoard);

              if (moveCost != 0) {
                if (algorithmNumber == 1) {
                  neighbours.add(
                    UNode(
                      board: newBoard,
                      cost: cost + moveCost,
                      goalBoard: goalBoard,
                      level: tempLevel,
                      prevNode: this,
                    ),
                  );
                } else if (algorithmNumber == 2) {
                  neighbours.add(
                    ANode(
                        board: newBoard,
                        cost: cost + moveCost,
                        goalBoard: goalBoard,
                        level: tempLevel,
                        prevNode: this),
                  );
                }
              }
            }
          }
        }
      }
    }

    return neighbours;
  }

  @override
  String toString() {
    return board.toString();
  }

  // Helper Functions
  static bool isLowerThan(Node n1, Node n2) {
    if (n1.heuristic != null && n2.heuristic != null) {
      return n1.cost + n1.heuristic! < n2.cost + n2.heuristic!;
    } else {
      return n1.cost < n2.cost;
    }
  }

  static bool isGreaterThan(Node n1, Node n2) {
    if (n1.heuristic != null && n2.heuristic != null) {
      return n1.cost + n1.heuristic! > n2.cost + n2.heuristic!;
    } else {
      return n1.cost > n2.cost;
    }
  }

  static List<List<Tile?>> copyBoard(List<List<Tile?>> board) {
    List<List<Tile?>> newBoard = [
      [null, null, null],
      [null, null, null],
      [null, null, null],
    ];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        newBoard[i][j] = board[i][j];
      }
    }

    return newBoard;
  }
}
