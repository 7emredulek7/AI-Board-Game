import 'package:flutter/material.dart';
import '../models/tile/tile.dart';
import '../view_models/board_view_model.dart';

class BoardWidget extends StatelessWidget {
  String boardName;
  BoardViewModel boardViewModel;

  BoardWidget({required this.boardName, required this.boardViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          boardName,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(50),
          height: 400,
          width: 400,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              int i = 0, j = index % 3;

              if (index >= 3 && index <= 5) {
                i = 1;
              } else if (index >= 6 && index <= 8) {
                i = 2;
              }

              Tile? tile = boardViewModel.board[i][j];

              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  color: tile != null ? tile.color : Colors.grey,
                ),
                onTap: () {
                  if (boardViewModel.selectedTile.color == Colors.blue) {
                    boardViewModel.setBlueTile(i, j);
                  } else if (boardViewModel.selectedTile.color ==
                      Colors.green) {
                    boardViewModel.setGreenTile(i, j);
                  } else if (boardViewModel.selectedTile.color == Colors.red) {
                    boardViewModel.setRedTile(i, j);
                  }
                },
              );
            },
            itemCount: 9,
          ),
        ),
      ],
    );
  }
}
