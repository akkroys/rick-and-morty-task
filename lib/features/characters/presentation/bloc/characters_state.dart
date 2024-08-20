part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  final List<Character> characters;

  const CharactersLoading(this.characters);

  @override
  List<Object> get props => [characters];
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final bool hasReachedMax;

  const CharactersLoaded({required this.characters, this.hasReachedMax = false});

  @override
  List<Object> get props => [characters, hasReachedMax];

  CharactersLoaded copyWith({
    List<Character>? characters,
    bool? hasReachedMax,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CharacterDetailsLoading extends CharactersState {}

class CharacterDetailsLoaded extends CharactersState {
  final Character character;

  const CharacterDetailsLoaded(this.character);

  @override
  List<Object> get props => [character];
}

class CharacterError extends CharactersState {
  final String message;

  const CharacterError(this.message);

  @override
  List<Object> get props => [message];
}