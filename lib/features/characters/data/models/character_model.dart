import 'dart:convert';

import 'package:rick_morty_task/features/characters/data/models/location_model.dart';
import 'package:rick_morty_task/features/characters/data/models/origin_model.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginModel origin;
  final LocationModel location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: OriginModel.fromJson(json['origin']),
      location: LocationModel.fromJson(json['location']),
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin.toJson(),
      'location': location.toJson(),
      'image': image,
      'episode': episode,
      'url': url,
      'created': created,
    };
  }

  String toJsonString() => jsonEncode(toJson());

  static CharacterModel fromJsonString(String jsonString) {
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return CharacterModel.fromJson(jsonMap);
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      gender: gender,
      originName: origin.name,
      locationName: location.name,
      imageUrl: image,
      firstEpisodeUrl: episode.isNotEmpty ? episode.first : '',
    );
  }
}
