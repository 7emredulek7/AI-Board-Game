import 'package:flutter/material.dart';

import 'tile.dart';

class BlueTile extends Tile {
  BlueTile() : super(color: Colors.blue);

  @override
  moveCost(String direction) {
    if (direction == 'right' || direction == 'left') {
      return 2;
    } else if (direction == 'up' || direction == 'down') {
      return 1;
    }
  }
}
