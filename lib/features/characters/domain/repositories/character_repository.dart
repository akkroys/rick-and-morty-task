import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters(
    int page,
    String status,
    String species,
  );
  Future<Either<Failure, Character>> getCharacterDetails(int id);
}
