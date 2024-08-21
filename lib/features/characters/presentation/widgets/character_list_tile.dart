import 'package:flutter/material.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/presentation/pages/character_detail_screen.dart';

class CharacterListTile extends StatelessWidget {
  final Character character;

  const CharacterListTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailScreen(
                characterId: character.id,
                characterName: character.name,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color:theme.cardColor,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                character.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              character.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              character.status,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
