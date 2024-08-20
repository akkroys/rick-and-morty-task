import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersInitial()) {
    on<CharactersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
