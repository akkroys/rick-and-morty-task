import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/settings_repository.dart';

class SaveThemeUseCase {
  final SettingsRepository repository;

  SaveThemeUseCase(this.repository);

  Future<Either<Failure, void>> execute(String theme) async {
    return await repository.saveTheme(theme);
  }
}

class GetThemeUseCase {
  final SettingsRepository repository;

  GetThemeUseCase(this.repository);

  Future<Either<Failure, String?>> execute() async {
    return await repository.getTheme();
  }
}
