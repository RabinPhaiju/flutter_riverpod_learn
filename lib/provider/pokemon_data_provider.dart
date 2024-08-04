import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/models/pokemon.dart';
import 'package:flutter_riverpod_learn/services/http_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../services/database_service.dart';

final pokemonDataProvider = FutureProvider.family<Pokemon?,String>((ref,url) async {
  HTTPService _httpService = GetIt.instance.get<HTTPService>();
  Response? res = await _httpService.get(url);

  if(res != null && res.data != null){
    return Pokemon.fromJson(res.data);
  }else{
  }

  return null;
});

final favoritePokemonsProvider = StateNotifierProvider<FavoritePokemonsProvider,List<String>>((ref){
  return FavoritePokemonsProvider([]);
});

class FavoritePokemonsProvider extends StateNotifier<List<String>>{
  final DatabaseService _databaseService = GetIt.instance.get<DatabaseService>();
  String FAVORITE_POKEMON_KEY = 'FAVORITE_POKEMON_KEY';
  FavoritePokemonsProvider(
  super._state,
  ){
    _setup();
  }

  Future<void> _setup() async{
    List<String>? result  = await _databaseService.getFavoriteList(FAVORITE_POKEMON_KEY);
    state = result;
  }

  void addFavoritePokemon(String url){
    state = [...state,url];
    _databaseService.saveList(FAVORITE_POKEMON_KEY, state);
  }

  void removeFavoritePokemon(String url){
    state = state.where((e)=>e != url).toList();
    _databaseService.saveList(FAVORITE_POKEMON_KEY, state);
  }
}