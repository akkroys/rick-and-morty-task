import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/features/characters/data/datasources/settings_local_data_source.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> saveTheme(String theme) async {
    try {
      await localDataSource.saveTheme(theme);
      return Right(null);
    } catch (e) {
      return Left(ThemeSaveFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getTheme() async {
    try {
      final theme = await localDataSource.getTheme();
      return Right(theme);
    } catch (e) {
      return Left(ThemeLoadFailure());
    }
  }
}
