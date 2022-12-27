import 'package:flutter/material.dart';

import 'tile.dart';

class GreenTile extends Tile {
  GreenTile() : super(color: Colors.green);

  @override
  moveCost(String direction) {
    if (direction == 'right' || direction == 'left') {
      return 1;
    } else if (direction == 'up' || direction == 'down') {
      return 2;
    }
  }
}
