import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DatabaseService {
  DatabaseService();

  Future<bool?> saveList(String key, List<String> value) async{
    try{
      const storage = FlutterSecureStorage();
      String jsonValue = jsonEncode(value);
      storage.write(key: key, value: jsonValue);
    }catch(e){
      debugPrint('$e');
    }
    return false;
  }

  Future<List<String>> getFavoriteList(String key) async {
    const storage = FlutterSecureStorage();
    String? jsonString = await storage.read(key: key);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<String>();
    }
    return [];
  }
}