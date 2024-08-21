part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {
  final int page;

  const LoadCharacters({required this.page});

  @override
  List<Object> get props => [page];
}

class LoadMoreCharacters extends CharactersEvent {
  final int page;

  const LoadMoreCharacters({required this.page});

  @override
  List<Object> get props => [page];
}

class LoadCharacterDetails extends CharactersEvent {
  final int characterId;

  const LoadCharacterDetails(this.characterId);

  @override
  List<Object> get props => [characterId];
}
