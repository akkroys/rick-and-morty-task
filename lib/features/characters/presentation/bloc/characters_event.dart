part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class LoadMoreCharacters extends CharactersEvent {}

class LoadCharacterDetails extends CharactersEvent {
  final int characterId;

  const LoadCharacterDetails(this.characterId);

  @override
  List<Object> get props => [characterId];
}