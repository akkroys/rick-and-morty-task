import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/exception.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/core/platform/network_info.dart';
import 'package:rick_morty_task/features/characters/data/datasources/character_local_data_source.dart';
import 'package:rick_morty_task/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:rick_morty_task/features/characters/data/models/character_model.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getCharacters(page);
        final remoteCharacters = remoteData['characters'] as List<CharacterModel>;
        await localDataSource.cacheCharacters(remoteCharacters);
        return Right(remoteCharacters.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacters = await localDataSource.getCachedCharacters();
        return Right(localCharacters.map((model) => model.toEntity()).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCharacter = await remoteDataSource.getCharacterDetails(id);
        return Right(remoteCharacter.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCharacter = await localDataSource.getCachedCharacterDetails(id);
        if (localCharacter != null) {
          return Right(localCharacter.toEntity());
        } else {
          return Left(CacheFailure());
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
