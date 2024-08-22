import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/character_model.dart';
import '../models/pagination_info_model.dart';

abstract class CharacterRemoteDataSource {
  Future<Map<String, dynamic>> getCharacters(
      int page, String status, String species);
  Future<CharacterModel> getCharacterDetails(int id);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> getCharacters(
      int page, String status, String species) async {
    final queryParameters = {
      'page': page.toString(),
      if (status.isNotEmpty) 'status': status,
      if (species.isNotEmpty) 'species': species,
    };

    final uri =
        Uri.https('rickandmortyapi.com', '/api/character', queryParameters);
        
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final List<CharacterModel> characters = (jsonMap['results'] as List)
          .map((characterJson) => CharacterModel.fromJson(characterJson))
          .toList();
      final PaginationInfoModel paginationInfo =
          PaginationInfoModel.fromJson(jsonMap['info']);
      return {
        'pagination': paginationInfo,
        'characters': characters,
      };
    } else {
      throw Exception('Failed to load characters');
    }
  }

  @override
  Future<CharacterModel> getCharacterDetails(int id) async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$id'),
    );

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load character details');
    }
  }
}
