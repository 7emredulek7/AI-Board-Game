import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/home_page.dart';
import '../locator.dart';
import '../view_models/board_view_model.dart';
import '../view_models/searching_view_model.dart';

// Run it as Web or Desktop Application

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InitBoardViewModel()),
        ChangeNotifierProvider(create: (context) => GoalBoardViewModel()),
        ChangeNotifierProvider(create: (context) => SearchingViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SE 420 Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
