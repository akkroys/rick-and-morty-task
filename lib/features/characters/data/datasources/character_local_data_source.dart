import 'package:rick_morty_task/features/characters/data/datasources/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<void> cacheCharacters(List<CharacterModel> characters);
  Future<List<CharacterModel>> getCachedCharacters();
  Future<CharacterModel?> getCachedCharacterDetails(int id);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final DatabaseHelper _dbHelper;

  CharacterLocalDataSourceImpl(this._dbHelper);

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    for (var character in characters) {
      batch.insert(
        'characters',
        character.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('characters');

    return maps.isNotEmpty
        ? maps.map((map) => CharacterModel.fromJson(map)).toList()
        : [];
  }

  @override
  Future<CharacterModel?> getCachedCharacterDetails(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'characters',
      where: 'id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty ? CharacterModel.fromJson(maps.first) : null;
  }
}
