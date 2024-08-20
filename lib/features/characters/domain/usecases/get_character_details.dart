import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<Either<Failure, Character>> call(int id) async {
    return await repository.getCharacterDetails(id);
  }
}
