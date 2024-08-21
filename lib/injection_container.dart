import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_morty_task/core/platform/network_info.dart';
import 'package:rick_morty_task/features/characters/data/datasources/character_local_data_source.dart';
import 'package:rick_morty_task/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:rick_morty_task/features/characters/data/datasources/db_helper.dart';
import 'package:rick_morty_task/features/characters/data/datasources/settings_local_data_source.dart';
import 'package:rick_morty_task/features/characters/data/repositories/character_repository_impl.dart';
import 'package:rick_morty_task/features/characters/data/repositories/settings_repository_impl.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/settings_repository.dart';
import 'package:rick_morty_task/features/characters/domain/usecases/get_character_details.dart';
import 'package:rick_morty_task/features/characters/domain/usecases/get_characters.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_task/features/characters/presentation/bloc/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => CharactersBloc(
        getCharacters: sl(),
        getCharacterDetails: sl(),
      ));

  sl.registerLazySingleton(() => GetCharacters(sl()));
  sl.registerLazySingleton(() => GetCharacterDetails(sl()));

  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CharacterRemoteDataSource>(
    () => CharacterRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  sl.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(sl<DatabaseHelper>()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  sl.registerFactory(() => ThemeBloc(settingsRepository: sl()));
}
