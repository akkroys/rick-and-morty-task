import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<void> saveTheme(String theme);
  Future<String?> getTheme();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveTheme(String theme) async {
    await sharedPreferences.setString('theme', theme);
  }

  @override
  Future<String?> getTheme() async {
    return sharedPreferences.getString('theme');
  }
}
