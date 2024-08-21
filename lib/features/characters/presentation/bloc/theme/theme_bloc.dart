import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_task/core/resources/theme.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/settings_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SettingsRepository settingsRepository;

  ThemeBloc({required this.settingsRepository}) : super(ThemeInitial()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final result = await settingsRepository.getTheme();
    result.fold(
      (failure) => emit(ThemeChanged(lightTheme)),
      (theme) {
        if (theme == 'dark') {
          emit(ThemeChanged(darkTheme));
        } else {
          emit(ThemeChanged(lightTheme));
        }
      },
    );
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final isDarkMode = state is ThemeChanged &&
        (state as ThemeChanged).themeData.brightness == Brightness.dark;

    final newTheme = isDarkMode ? lightTheme : darkTheme;
    final themeName = isDarkMode ? 'light' : 'dark';

    final result = await settingsRepository.saveTheme(themeName);
    result.fold(
      (failure) => emit(state),
      (_) => emit(ThemeChanged(newTheme)),
    );
  }
}
