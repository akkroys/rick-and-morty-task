import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, void>> saveTheme(String theme);
  Future<Either<Failure, String?>> getTheme();
}
