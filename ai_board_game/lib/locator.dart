import 'package:get_it/get_it.dart';
import '../models/tile/blue_tile.dart';
import '../models/tile/green_tile.dart';
import '../models/tile/red_tile.dart';
import '../services/alg_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AlgService());
  locator.registerLazySingleton(() => BlueTile());
  locator.registerLazySingleton(() => RedTile());
  locator.registerLazySingleton(() => GreenTile());
}
