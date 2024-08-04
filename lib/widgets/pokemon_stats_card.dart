import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learn/provider/pokemon_data_provider.dart';

class PokemonStatsCard extends ConsumerWidget {
  final String pokemonUrl;
  const PokemonStatsCard({super.key,required this.pokemonUrl});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonUrl));
    return AlertDialog(
      title: Text('Stats'),
      content: pokemon.when(
          data: (data){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: data!.stats!.map((s){
                return Text('${s.stat?.name}: ${s.baseStat}');
              }).toList(),
            );
          },
          error: (error,stackTrace){
            return Text('$error');
          },
          loading: (){
            return CircularProgressIndicator();
          }
      ),
    );
  }
}
