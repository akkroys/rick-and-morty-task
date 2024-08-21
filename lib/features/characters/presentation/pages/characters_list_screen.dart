import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty_task/features/characters/presentation/pages/settings_screen.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/character_list_tile.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/loading_icon.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    BlocProvider.of<CharactersBloc>(context).add(const LoadCharacters(page: 1));
  }

  Future<void> _fetchPage(int pageKey) async {
    final bloc = BlocProvider.of<CharactersBloc>(context);
    bloc.add(LoadMoreCharacters(page: pageKey));

    bloc.stream.listen((state) {
      if (state is CharactersLoaded) {
        final isLastPage = state.hasReachedMax;
        if (isLastPage) {
          _pagingController.appendLastPage(state.characters);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(state.characters, nextPageKey);
        }
      } else if (state is CharacterError) {
        _pagingController.error = state.message;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavBarTheme = theme.bottomNavigationBarTheme;
    final selectedColor = bottomNavBarTheme.selectedItemColor!;
    final unselectedColor = bottomNavBarTheme.unselectedItemColor!;

    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 ? Text("Characters") : Text("Settings"),
      ),
      body: _selectedIndex == 0 ? _buildCharactersList() : SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/characters_active.svg",
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? selectedColor : unselectedColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Characters",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _selectedIndex == 1 ? selectedColor : unselectedColor,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersList() {
    return PagedListView<int, Character>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Character>(
        itemBuilder: (context, character, index) =>
            CharacterListTile(character: character),
        firstPageErrorIndicatorBuilder: (context) => Center(
          child: Text('Error loading characters'),
        ),
        firstPageProgressIndicatorBuilder: (context) => Center(
            child: CustomLoadingIcon(
                assetPath: "assets/icons/characters_active.svg")),
        newPageProgressIndicatorBuilder: (context) =>
            CustomLoadingIcon(assetPath: "assets/icons/characters_active.svg"),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: Text('No characters found'),
        ),
      ),
    );
  }
}
