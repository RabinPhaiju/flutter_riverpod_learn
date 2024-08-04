import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learn/provider/pokemon_data_provider.dart';

class PokemonListTile extends ConsumerWidget {
  final String? pokemonUrl;
  late FavoritePokemonsProvider _favoritePokemonProvider;
  late List<String> _favoritePokemons;
  PokemonListTile({super.key,required this.pokemonUrl});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    _favoritePokemonProvider = ref.watch(favoritePokemonsProvider.notifier);
    _favoritePokemons = ref.watch(favoritePokemonsProvider);
    final poke = ref.watch(pokemonDataProvider(pokemonUrl ?? ''));
    return poke.when(
        data: (data){
          return ListTile(
            leading: data != null
              ? CircleAvatar(
              backgroundImage: NetworkImage(data.sprites!.frontDefault!),
            )
              : const CircleAvatar(),
            trailing: IconButton(
              onPressed: (){
                if(_favoritePokemons.contains(pokemonUrl)){
                  _favoritePokemonProvider.removeFavoritePokemon(pokemonUrl!);
                }else{
                  _favoritePokemonProvider.addFavoritePokemon(pokemonUrl!);

                }
              },
              icon: Icon(
                color: Colors.red,
                _favoritePokemons.contains(pokemonUrl)
                    ? Icons.favorite
                    : Icons.favorite_border
              ),
            ),
            title: Text(data?.name ?? ''),
            subtitle: Text('Has ${data?.moves?.length} moves'),
          );
        },
        error: (error,stackTrace){
          return Text('$error');
        },
        loading: (){
          return const Text('Loading...');
        }
    ) ;
  }
}
