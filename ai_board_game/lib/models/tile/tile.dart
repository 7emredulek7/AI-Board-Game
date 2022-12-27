import 'package:flutter/material.dart';

abstract class Tile {
  Color color;
  moveCost(String direction);

  Tile({required this.color});
}
