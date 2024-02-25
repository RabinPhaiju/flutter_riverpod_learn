// replace of futureBuilder
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

@immutable
class UserFuture {
  final String name;
  final String email;

  const UserFuture(this.name, this.email);

  //copyWith
  UserFuture copyWith({String? name, String? email}) {
    return UserFuture(name ?? this.name, email ?? this.email);
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  // fromMap
  factory UserFuture.fromMap(Map<String, dynamic> map) {
    return UserFuture(
      map['name'] as String,
      map['email'] as String,
    );
  }

  // fromJson
  factory UserFuture.fromJson(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return UserFuture.fromMap(json);
  }
}

// final userFutureRepositoryProvider = Provider((ref) => UserFutureRepository(http.Client(),ref));
final userFutureRepositoryProvider = Provider.autoDispose((ref) => UserFutureRepository(http.Client(),ref));

class UserFutureRepository {
  final Ref ref;
  final http.Client client;
  UserFutureRepository(this.client, this.ref);

  Future<UserFuture> fetchUser(String input) {
    final url = 'https://jsonplaceholder.typicode.com/users/$input';
    return client.get(Uri.parse(url)).then((value) {
      return UserFuture.fromJson(value.body);
    });
  }
}
