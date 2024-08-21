import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/theme/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                bool isDarkMode = state is ThemeChanged &&
                    state.themeData.brightness == Brightness.dark;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode', style: TextStyle(fontSize: 16)),
                    Switch(
                      value: isDarkMode,
                      activeColor: isDarkMode ? Color(0xff9595FE) : Color(0xffB3B3B3),
                      onChanged: (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ToggleThemeEvent());
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
