part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeData themeData;

  const ThemeChanged(this.themeData);

  @override
  List<Object> get props => [themeData];
}