
import '../../models/pokemon.dart';

class PokemonPageData {
  PokemonListData? data;

  PokemonPageData({
    required this.data,
  });

  PokemonPageData.initial() : data = null;

  PokemonPageData copyWith({PokemonListData? data}) {
    return PokemonPageData(
      data: data ?? this.data,
    );
  }
}