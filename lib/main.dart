import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_task/core/resources/theme.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/theme/theme_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/pages/characters_list_screen.dart';
import 'package:rick_morty_task/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<CharactersBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<ThemeBloc>()..add(LoadThemeEvent()),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData themeData = lightTheme;

          if (state is ThemeChanged) {
            themeData = state.themeData;
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick and Morty Characters',
            theme: themeData,
            home: CharactersListScreen(),
          );
        },
      ),
    );
  }
}
