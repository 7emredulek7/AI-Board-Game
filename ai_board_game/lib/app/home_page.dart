import 'package:ai_board_game/app/results_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import '../models/tile/blue_tile.dart';
import '../models/tile/green_tile.dart';
import '../models/tile/red_tile.dart';
import '../models/tile/tile.dart';
import '../view_models/board_view_model.dart';
import '../view_models/searching_view_model.dart';
import 'board_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final initBoardViewModel = Provider.of<InitBoardViewModel>(context);
    final goalBoardViewModel = Provider.of<GoalBoardViewModel>(context);
    final searchingViewModel = Provider.of<SearchingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SE 420 Project",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _algorithmButtons(context, searchingViewModel, initBoardViewModel,
              goalBoardViewModel),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: _tileDropdown(initBoardViewModel, goalBoardViewModel)),
              Expanded(
                  child:
                      _orderDropdown(initBoardViewModel, goalBoardViewModel)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoardWidget(
                boardName: "Initial Node",
                boardViewModel: initBoardViewModel,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.grey,
                height: 500,
                width: 2,
              ),
              BoardWidget(
                boardName: "Goal Node",
                boardViewModel: goalBoardViewModel,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tileDropdown(InitBoardViewModel initBoardViewModel,
      GoalBoardViewModel goalBoardViewModel) {
    final blueTile = locator<BlueTile>();
    final greenTile = locator<GreenTile>();
    final redTile = locator<RedTile>();

    Tile selectedTile = initBoardViewModel.selectedTile;

    return Padding(
      padding: const EdgeInsets.only(left: 300, right: 50, bottom: 30, top: 30),
      child: DropdownButtonFormField(
        value: selectedTile,
        decoration: const InputDecoration(
          label: Text("Tile Color"),
          icon: Icon(
            Icons.palette,
          ),
        ),
        items: [
          DropdownMenuItem(
            value: blueTile,
            child: const Text(
              "Blue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: greenTile,
            child: const Text(
              "Green",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: redTile,
            child: const Text(
              "Red",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
        onChanged: (tile) {
          if (tile != null) {
            initBoardViewModel.selectedTile = tile;
            goalBoardViewModel.selectedTile = tile;
          }
        },
      ),
    );
  }

  Widget _orderDropdown(InitBoardViewModel initBoardViewModel,
      GoalBoardViewModel goalBoardViewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 300, bottom: 30, top: 30),
      child: DropdownButtonFormField(
        value: initBoardViewModel.orderAsString,
        decoration: const InputDecoration(
          label: Text("Order"),
          icon: Icon(
            Icons.numbers,
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: "Blue,Green,Red",
            child: Text(
              "Blue, Green, Red",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "Blue,Red,Green",
            child: Text(
              "Blue, Red, Green",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "Green,Blue,Red",
            child: Text(
              "Green, Blue, Red",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "Green,Red,Blue",
            child: Text(
              "Green, Red, Blue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "Red,Green,Blue",
            child: Text(
              "Red, Green, Blue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          DropdownMenuItem(
            value: "Red,Blue,Green",
            child: Text(
              "Red, Blue, Green",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
        onChanged: (order) {
          if (order != null) {
            initBoardViewModel.orderAsString = order;
          }
        },
      ),
    );
  }

  Widget _algorithmButtons(
      BuildContext context,
      SearchingViewModel searchingViewModel,
      InitBoardViewModel initBoardViewModel,
      GoalBoardViewModel goalBoardViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          minWidth: 200,
          disabledColor: Colors.grey.shade300,
          color: Colors.blue,
          onPressed:
              initBoardViewModel.isComplete() && goalBoardViewModel.isComplete()
                  ? () async {
                      searchingViewModel.startSearching(
                          2,
                          initBoardViewModel.board,
                          goalBoardViewModel.board,
                          initBoardViewModel.order);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResultsPage(algName: "A* Search")));
                    }
                  : null,
          child: const Text(
            "A* Search",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        MaterialButton(
          minWidth: 200,
          disabledColor: Colors.grey.shade300,
          color: Colors.blue,
          onPressed:
              initBoardViewModel.isComplete() && goalBoardViewModel.isComplete()
                  ? () async {
                      searchingViewModel.startSearching(
                          1,
                          initBoardViewModel.board,
                          goalBoardViewModel.board,
                          initBoardViewModel.order);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResultsPage(algName: "Uniform Cost Search")));
                    }
                  : null,
          child: const Text(
            "Uniform Cost Search",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
