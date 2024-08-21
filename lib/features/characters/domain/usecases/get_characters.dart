import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/core/usecase/usecase.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';

class GetCharacters extends UseCase<List<Character>, GetCharactersParams> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(GetCharactersParams params) async {
    return await repository.getCharacters(params.page);
  }
}

class GetCharactersParams extends Equatable {
  final int page;

  const GetCharactersParams({required this.page});

  @override
  List<Object> get props => [page];
}