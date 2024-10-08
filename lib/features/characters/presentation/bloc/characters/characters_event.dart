part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {
  final int page;
  final String status;
  final String species;

  const LoadCharacters({
    required this.page,
    this.status = '',
    this.species = '',
  });

  @override
  List<Object> get props => [page, status, species];
}

class LoadMoreCharacters extends CharactersEvent {
  final int page;
  final String? status;
  final String? species;

  const LoadMoreCharacters({
    required this.page,
    this.status,
    this.species,
  });

  @override
  List<Object> get props => [page, status ?? '', species ?? ''];
}

class LoadCharacterDetails extends CharactersEvent {
  final int characterId;

  const LoadCharacterDetails(this.characterId);

  @override
  List<Object> get props => [characterId];
}
