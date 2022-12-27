import 'package:flutter/material.dart';
import '../locator.dart';
import '../models/tile/blue_tile.dart';
import '../models/tile/green_tile.dart';
import '../models/tile/red_tile.dart';
import '../models/tile/tile.dart';

class BoardViewModel with ChangeNotifier {
  late List<List<Tile?>> board;
  late Tile _selectedTile;

  late List<Tile> _order;

  BoardViewModel() {
    _selectedTile = locator<BlueTile>();
    _order = [locator<BlueTile>(), locator<GreenTile>(), locator<RedTile>()];

    board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];
  }

  Tile get selectedTile => _selectedTile;

  set selectedTile(Tile tile) {
    _selectedTile = tile;
    notifyListeners();
  }

  List<Tile> get order => _order;

  String get orderAsString {
    List<String> tileNames = [];

    for (Tile tile in _order) {
      if (tile == locator<BlueTile>()) {
        tileNames.add("Blue");
      } else if (tile == locator<GreenTile>()) {
        tileNames.add("Green");
      } else if (tile == locator<RedTile>()) {
        tileNames.add("Red");
      }
    }

    String tiles = "";
    for (int i = 0; i < tileNames.length; i++) {
      if (i != tileNames.length - 1) {
        tiles += "${tileNames[i]},";
      } else {
        tiles += tileNames[i];
      }
    }

    return tiles;
  }

  set orderAsString(String order) {
    List<String> tileNames = order.split(",");
    List<Tile> tiles = [];

    for (String tileName in tileNames) {
      switch (tileName) {
        case "Blue":
          tiles.add(locator<BlueTile>());
          break;
        case "Red":
          tiles.add(locator<RedTile>());
          break;
        case "Green":
          tiles.add(locator<GreenTile>());
          break;
      }
    }

    _order = tiles;
  }

  setBlueTile(int index1, int index2) {
    Tile blueTile = locator<BlueTile>();

    if (board[index1][index2] == null) {
      _reset(blueTile);
      board[index1][index2] = blueTile;
    }
    notifyListeners();
  }

  setGreenTile(int index1, int index2) {
    Tile greenTile = locator<GreenTile>();

    if (board[index1][index2] == null) {
      _reset(greenTile);
      board[index1][index2] = greenTile;
    }
    notifyListeners();
  }

  setRedTile(int index1, int index2) {
    Tile redTile = locator<RedTile>();

    if (board[index1][index2] == null) {
      _reset(redTile);
      board[index1][index2] = redTile;
    }
    notifyListeners();
  }

  _reset(Tile tile) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        Tile? t = board[i][j];
        if (t != null && t.color == tile.color) {
          board[i][j] = null;
          break;
        }
      }
    }
  }

  bool isComplete() {
    bool containsBlue = false, containsRed = false, containsGreen = false;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        Tile? t = board[i][j];

        if (!containsBlue && t != null && (t.color == Colors.blue)) {
          containsBlue = true;
        }

        if (!containsRed && t != null && (t.color == Colors.red)) {
          containsRed = true;
        }

        if (!containsGreen && t != null && (t.color == Colors.green)) {
          containsGreen = true;
        }

        if (containsBlue && containsRed && containsGreen) {
          return containsBlue && containsRed && containsGreen;
        }
      }
    }

    return containsBlue && containsRed && containsGreen;
  }
}

class InitBoardViewModel extends BoardViewModel {}

class GoalBoardViewModel extends BoardViewModel {}
