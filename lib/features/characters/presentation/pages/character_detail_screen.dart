import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/character_detail_item.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/loading_icon.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;
  final String characterName;

  const CharacterDetailScreen(
      {super.key, required this.characterId, required this.characterName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          characterName,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => CharactersBloc(
          getCharacters: context.read<CharactersBloc>().getCharacters,
          getCharacterDetails:
              context.read<CharactersBloc>().getCharacterDetails,
        )..add(LoadCharacterDetails(characterId)),
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is CharacterDetailsLoading) {
              return const Center(
                child: CustomLoadingIcon(
                  assetPath: "assets/icons/characters_active.svg",
                ),
              );
            } else if (state is CharacterDetailsLoaded) {
              final character = state.character;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: CachedNetworkImage(
                                imageUrl: character.imageUrl,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Image.asset(
                                    'assets/icons/unknown_character.jpeg'),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                        'assets/icons/unknown_character.jpeg'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    character.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: screenWidth,
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 20),
                        CharacterDetailItem(
                          title: 'Status',
                          value: character.status,
                        ),
                        CharacterDetailItem(
                          title: 'Species',
                          value: character.species,
                        ),
                        CharacterDetailItem(
                          title: 'Gender',
                          value: character.gender,
                        ),
                        CharacterDetailItem(
                          title: 'Origin',
                          value: character.originName,
                        ),
                        CharacterDetailItem(
                          title: 'Last Known Location',
                          value: character.locationName,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is CharacterError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                  child: Text('No Character Details Available'));
            }
          },
        ),
      ),
    );
  }
}
