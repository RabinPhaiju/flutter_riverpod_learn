import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/provider/pokemon_data_provider.dart';
import 'package:flutter_riverpod_learn/widgets/pokemon_stats_card.dart';

import '../models/pokemon.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonUrl;
  const PokemonCard({super.key,required this.pokemonUrl});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final favoritePokemonProvider = ref.watch(favoritePokemonsProvider.notifier);
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return pokemon.when(
        data: (data){
          return _card(context,data,favoritePokemonProvider);
        },
        error: (error,stackTrace){
          return Text('$error');
        },
        loading: (){
          return const Text('Loading...');
        }
    );
  }

  Widget _card(BuildContext context, Pokemon? pokemon,FavoritePokemonsProvider favoritePokemonProvider ){
    Size size = MediaQuery.sizeOf(context);
    TextStyle style = const TextStyle(color: Colors.white);
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            builder: (_){
              return PokemonStatsCard(pokemonUrl: pokemonUrl);
            }
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.03,vertical: size.height * 0.01),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03,vertical: size.height * 0.01),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(34, 34, 34, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(pokemon?.name ?? '',style: style,),
                Text(pokemon?.id.toString() ?? '',style: style,),
              ],
            ),
            Expanded(
                child: pokemon != null  ? CircleAvatar(backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),radius: 50,) : const SizedBox.shrink()
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${pokemon?.moves?.length} moves',style: style,),
                IconButton(onPressed: (){
                  favoritePokemonProvider.removeFavoritePokemon(pokemonUrl);
                },
                    icon: Icon(Icons.favorite,color: Colors.red,))
              ],
            )

          ],
        ),
      ),
    );
  }
}
