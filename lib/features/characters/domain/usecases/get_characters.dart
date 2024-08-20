import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_task/core/error/failure.dart';
import 'package:rick_morty_task/core/usecase/usecase.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';

class GetCharacterDetails
    extends UseCase<Character, GetCharacterDetailsParams> {
  final CharacterRepository repository;

  GetCharacterDetails(this.repository);

  @override
  Future<Either<Failure, Character>> call(GetCharacterDetailsParams params) async {
    return await repository.getCharacterDetails(params.id);
  }
}

class GetCharacterDetailsParams extends Equatable {
  final int id;

  const GetCharacterDetailsParams({required this.id});

  @override
  List<Object> get props => [id];
}
