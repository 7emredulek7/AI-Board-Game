import 'package:flutter/material.dart';

import 'tile.dart';

class RedTile extends Tile {
  RedTile() : super(color: Colors.red);

  @override
  moveCost(String direction) {
    if (direction == 'right' || direction == 'left') {
      return 1;
    } else if (direction == 'up' || direction == 'down') {
      return 1;
    }
  }
}
