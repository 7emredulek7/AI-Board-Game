import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/node/node.dart';
import '../models/tile/tile.dart';
import '../view_models/searching_view_model.dart';

class ResultsPage extends StatelessWidget {
  String algName;

  ResultsPage({super.key, required this.algName});

  @override
  Widget build(BuildContext context) {
    final searchingViewModel = Provider.of<SearchingViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Searching Results ( $algName )"),
      ),
      body: searchingViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: _expandedOrder(searchingViewModel)),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.grey,
                    height: double.maxFinite,
                    width: 3,
                  ),
                  Expanded(child: _fringe(searchingViewModel)),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.grey,
                    height: double.maxFinite,
                    width: 3,
                  ),
                  Expanded(child: _solutionPath(searchingViewModel)),
                ],
              ),
            ),
    );
  }

  Widget _solutionPath(SearchingViewModel searchingViewModel) {
    List<Node> steps = searchingViewModel.solutionWithSteps();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text(
                "SOLUTION PATH",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              searchingViewModel.searchingResult!.result != null
                  ? Text(
                      "Total Cost: ${searchingViewModel.searchingResult!.result!.cost}")
                  : const Text("There is no solution...")
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              Node n = steps[index];

              return Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text("STEP ${index + 1}:"),
                    ],
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.all(5),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        int i = 0, j = index % 3;

                        if (index >= 3 && index <= 5) {
                          i = 1;
                        } else if (index >= 6 && index <= 8) {
                          i = 2;
                        }

                        Tile? tile = n.board[i][j];

                        return Container(
                          margin: const EdgeInsets.all(10),
                          color: tile != null ? tile.color : Colors.grey,
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                  Container(
                    width: 450,
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              );
            },
            itemCount: steps.length,
          ),
        ),
      ],
    );
  }

  Widget _expandedOrder(SearchingViewModel searchingViewModel) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text(
                "EXPANDED ORDER",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              Node n = searchingViewModel.searchingResult!.expandedNodes[index];

              return Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text("Expanded Node ${index + 1}: (cost: ${n.cost})"),
                    ],
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.all(5),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        int i = 0, j = index % 3;

                        if (index >= 3 && index <= 5) {
                          i = 1;
                        } else if (index >= 6 && index <= 8) {
                          i = 2;
                        }

                        Tile? tile = n.board[i][j];

                        return Container(
                          margin: const EdgeInsets.all(10),
                          color: tile != null ? tile.color : Colors.grey,
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                  Container(
                    width: 450,
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              );
            },
            itemCount: searchingViewModel.searchingResult!.expandedNodes.length,
          ),
        ),
      ],
    );
  }

  Widget _fringe(SearchingViewModel searchingViewModel) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: const Text(
                "FRINGE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              Node n = searchingViewModel.searchingResult!.fringe[index];

              return Column(
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      Text("Node ${index + 1}: (cost: ${n.cost})"),
                    ],
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.all(5),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        int i = 0, j = index % 3;

                        if (index >= 3 && index <= 5) {
                          i = 1;
                        } else if (index >= 6 && index <= 8) {
                          i = 2;
                        }

                        Tile? tile = n.board[i][j];

                        return Container(
                          margin: const EdgeInsets.all(10),
                          color: tile != null ? tile.color : Colors.grey,
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                  Container(
                    width: 450,
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              );
            },
            itemCount: searchingViewModel.searchingResult!.fringe.length,
          ),
        ),
      ],
    );
  }
}
