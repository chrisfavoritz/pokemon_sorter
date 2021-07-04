import 'package:get_it/get_it.dart';
import 'package:pokemon_sorter/cards/card_sorter.dart';
import 'package:pokemon_sorter/services/shared_preferences_storage.dart';
import 'package:pokemon_sorter/services/storage_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // state management layer
  getIt.registerLazySingleton<CardSorter>(() => CardSorter());

  getIt.registerLazySingleton<StorageService>(() => SharedPreferencesStorage());

}