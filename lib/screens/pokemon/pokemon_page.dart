import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/provider/pokemon_data_provider.dart';
import 'package:flutter_riverpod_learn/provider/pokemon_provider.dart';
import 'package:flutter_riverpod_learn/screens/pokemon/pokemon_page_data.dart';
import 'package:flutter_riverpod_learn/widgets/pokemon_cards.dart';

import '../../models/pokemon.dart';
import '../../widgets/pokemon_list_tile.dart';

final pokemonPageProvider = StateNotifierProvider<PokemonProvider,PokemonPageData>((ref){
  return PokemonProvider(PokemonPageData.initial());
});

class PokemonPage extends ConsumerStatefulWidget {
  const PokemonPage({super.key});

  @override
  ConsumerState<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends ConsumerState<PokemonPage> {
  final ScrollController _scrollController = ScrollController();
  late PokemonProvider _pokemonProvider;
  late PokemonPageData _pokemonPageData;

  late List<String> _favoritePokemons;

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener(){
    if(_scrollController.offset >= _scrollController.position.maxScrollExtent * 1 && !_scrollController.position.outOfRange){
      _pokemonProvider.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    _pokemonProvider = ref.watch(pokemonPageProvider.notifier);
    _pokemonPageData = ref.watch(pokemonPageProvider);
    _favoritePokemons = ref.watch(favoritePokemonsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Poke Api'),
      ),
      body: _buildUI(context,),
    );
  }

  Widget _buildUI(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _favoritePokemonsList(context),
                _allPokemonList(context)
              ],
            ),
          ),
        )
    );
  }

  Widget _favoritePokemonsList(BuildContext context){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Favorites"
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                _favoritePokemons.isEmpty
                  ? const Text('No favorite pokemons yet!.')
                  :  Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: _favoritePokemons.length,
                        itemBuilder : (context,index){
                          return PokemonCard(pokemonUrl: _favoritePokemons[index]);
                        }
                       ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _allPokemonList(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Text('All Pokemon'),
          SizedBox(
            height: size.height*0.6,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _pokemonPageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult? item = _pokemonPageData.data?.results?[index];
                return PokemonListTile(pokemonUrl: item?.url);
              },
            ),
          )
        ],
      )
    );
  }
}
