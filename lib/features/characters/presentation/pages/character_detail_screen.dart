import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/character_detail_item.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/loading_icon.dart';

class CharacterDetailScreen extends StatelessWidget {
  final int characterId;
  final String characterName;

  CharacterDetailScreen(
      {super.key, required this.characterId, required this.characterName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // final nameLines = characterName.split(' ').join('\n');
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          characterName,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
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
              return Center(
                child: CustomLoadingIcon(
                  assetPath: "assets/icons/characters_active.svg",
                ),
              );
            } else if (state is CharacterDetailsLoaded) {
              final character = state.character;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  character.imageUrl,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      character.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: screenWidth,
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
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
                ),
              );
            } else if (state is CharacterError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('No Character Details Available'));
            }
          },
        ),
      ),
    );
  }
}
