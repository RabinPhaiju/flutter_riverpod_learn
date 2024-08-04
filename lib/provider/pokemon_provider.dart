import 'package:flutter_riverpod_learn/models/pokemon.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/screens/pokemon/pokemon_page_data.dart';
import 'package:dio/dio.dart';
import '../services/http_service.dart';

class PokemonProvider extends StateNotifier<PokemonPageData>{
  final GetIt _getIt = GetIt.instance;
  late HTTPService _httpService;
  PokemonProvider(
      super._state
      ){
    _httpService = _getIt.get<HTTPService>();
    _setup();
  }

  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if(state.data == null){
      Response? res = await _httpService.get('https://pokeapi.co/api/v2/pokemon?limit=20&offset=0');
      if(res != null && res.data != null){
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data:data);
      }
    }else{
      print('---------- test');
      if(state.data?.next != null){
        Response? res = await _httpService.get(state.data!.next!);
        if(res != null && res.data != null){
          PokemonListData data = PokemonListData.fromJson(res.data);
          state = state.copyWith(data:data.copyWith(results: [...?state.data?.results,...?data.results]));
        }
      }
    }
  }
}

