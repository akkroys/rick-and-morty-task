import 'package:dartz/dartz.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/core/usecase/usecase.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';

class GetCharacters extends UseCase<List<Character>, NoParams> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(NoParams params) async {
    return await repository.getCharacters(); 
  }
}