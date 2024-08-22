import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_morty_task/core/platform/network_info.dart';
import 'package:rick_morty_task/features/characters/domain/entities/character.dart';
import 'package:rick_morty_task/features/characters/domain/repositories/character_repository.dart';
import 'package:rick_morty_task/features/characters/presentation/bloc/characters/characters_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rick_morty_task/features/characters/presentation/pages/settings_screen.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/character_list_tile.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/filter_options.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/loading_icon.dart';
import 'package:rick_morty_task/features/characters/presentation/widgets/show_no_internet_dialog.dart';
import 'package:rick_morty_task/injection_container.dart' as di;

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  int _selectedIndex = 0;
  bool _isFilterVisible = false;
  String _selectedStatus = 'All';
  String _selectedSpecies = 'All';
  bool _isConnected = false;
  Timer? _connectionCheckTimer;
  final networkInfo = di.sl<NetworkInfo>();

  Future<void> _checkInternetConnection() async {
    final isConnected = await networkInfo.isConnected;

    if (mounted) {
      setState(() {
        _isConnected = isConnected;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) _isFilterVisible = false;
    });
  }

  void _toggleFilter() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _applyFilter() {
    _pagingController.refresh();
  }

  void _resetFilter() {
    setState(() {
      _selectedStatus = 'All';
      _selectedSpecies = 'All';
    });
    _applyFilter();
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _connectionCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _checkInternetConnection();
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    BlocProvider.of<CharactersBloc>(context).add(const LoadCharacters(page: 1));
  }

  Future<void> _fetchPage(int pageKey) async {
    final bloc = BlocProvider.of<CharactersBloc>(context);

    if (await networkInfo.isConnected) {
      bloc.add(LoadMoreCharacters(
        page: pageKey,
        status: _selectedStatus != 'All' ? _selectedStatus.toLowerCase() : null,
        species:
            _selectedSpecies != 'All' ? _selectedSpecies.toLowerCase() : null,
      ));
    } else {
      showNoInternetDialog(context);
      try {
        final charactersResult = await context
            .read<CharacterRepository>()
            .getCharacters(
                pageKey,
                _selectedStatus != 'All' ? _selectedStatus.toLowerCase() : '',
                _selectedSpecies != 'All'
                    ? _selectedSpecies.toLowerCase()
                    : '');
        charactersResult.fold(
          (failure) => _pagingController.error = 'Error loading cached data',
          (characters) {
            if (characters.isEmpty) {
              _pagingController.appendLastPage(characters);
            } else {
              _pagingController.appendPage(characters, pageKey + 1);
            }
          },
        );
      } catch (_) {
        _pagingController.error = 'Error loading cached data';
      }
    }

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
    _connectionCheckTimer?.cancel();
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
        title: _selectedIndex == 0
            ? const Text("Characters")
            : const Text("Settings"),
        actions: _selectedIndex == 0 && _isConnected
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _toggleFilter,
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          if (_isFilterVisible)
            FilterOptions(
              selectedStatus: _selectedStatus,
              selectedSpecies: _selectedSpecies,
              onStatusChanged: (newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
                _applyFilter();
              },
              onSpeciesChanged: (newValue) {
                setState(() {
                  _selectedSpecies = newValue!;
                });
                _applyFilter();
              },
              onReset: _resetFilter,
            ),
          Expanded(
            child: _selectedIndex == 0
                ? _buildCharactersList()
                : const SettingsScreen(),
          ),
        ],
      ),
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
        firstPageErrorIndicatorBuilder: (context) => const Center(
          child: Text('Error loading characters'),
        ),
        firstPageProgressIndicatorBuilder: (context) => const Center(
            child: CustomLoadingIcon(
                assetPath: "assets/icons/characters_active.svg")),
        newPageProgressIndicatorBuilder: (context) => const CustomLoadingIcon(
            assetPath: "assets/icons/characters_active.svg"),
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: Text('No characters found'),
        ),
      ),
    );
  }
}
