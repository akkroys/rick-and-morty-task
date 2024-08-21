import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCachedCharacters();
  Future<CharacterModel?> getCachedCharacterDetails(int id);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences _prefs;
  static const String _charactersKey = 'characters_key';

  CharacterLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final List<String> characterJsonList =
        characters.map((c) => c.toJsonString()).toList();
    await _prefs.setStringList(_charactersKey, characterJsonList);
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final List<String>? characterJsonList =
        _prefs.getStringList(_charactersKey);
    if (characterJsonList != null) {
      return characterJsonList
          .map((jsonString) => CharacterModel.fromJsonString(jsonString))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<CharacterModel?> getCachedCharacterDetails(int id) async {
    final characters = await getCachedCharacters();
    try {
      return characters.firstWhere((character) => character.id == id);
    } catch (e) {
      return null;
    }
  }
}
