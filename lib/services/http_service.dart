import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HTTPService {
  HTTPService();

  final _dio = Dio();

  Future<Response?> get(String path) async {
    try{
      Response res = await _dio.get(path);
      return res;
    }catch(e){
      debugPrint('$e');
    }
    return null;
  }

}