import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_morty_task/core/usecase/usecase.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/usecases/get_character_details.dart';
import 'package:rick_morty_task/features/characters/domain/usecases/get_characters.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharacters getCharacters;
  final GetCharacterDetails getCharacterDetails;

  CharactersBloc({
    required this.getCharacters,
    required this.getCharacterDetails,
  }) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
    on<LoadCharacterDetails>(_onLoadCharacterDetails);
  }

  void _onLoadCharacters(
      LoadCharacters event, Emitter<CharactersState> emit) async {
    emit(CharactersLoading([]));
    final charactersResult = await getCharacters(NoParams());
    charactersResult.fold(
      (failure) => emit(CharacterError("Error loading characters")),
      (characters) => emit(CharactersLoaded(characters: characters)),
    );
  }

  void _onLoadMoreCharacters(
      LoadMoreCharacters event, Emitter<CharactersState> emit) async {
    final currentState = state;
    if (currentState is CharactersLoaded && !currentState.hasReachedMax) {
      emit(CharactersLoading(currentState.characters));
      final charactersResult = await getCharacters(NoParams());
      charactersResult.fold(
        (failure) => emit(CharacterError("Error loading characters")),
        (characters) {
          if (characters.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true));
          } else {
            emit(CharactersLoaded(
              characters: currentState.characters + characters,
            ));
          }
        },
      );
    }
  }

  void _onLoadCharacterDetails(
      LoadCharacterDetails event, Emitter<CharactersState> emit) async {
    emit(CharacterDetailsLoading());
    final characterResult = await getCharacterDetails(
        GetCharacterDetailsParams(id: event.characterId));
    characterResult.fold(
      (failure) => emit(CharacterError("Ошибка загрузки деталей персонажа")),
      (character) => emit(CharacterDetailsLoaded(character)),
    );
  }
}
