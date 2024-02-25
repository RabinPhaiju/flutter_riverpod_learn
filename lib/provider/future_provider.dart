// replace of futureBuilder
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart';

@immutable
class UserEntity {
  final String name;
  final String email;

  const UserEntity(this.name, this.email);

  //copyWith
  UserEntity copyWith({String? name, String? email}) {
    return UserEntity(name ?? this.name, email ?? this.email);
  }

  // toMap
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email,};
  }

  // fromMap
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      map['name'] as String,
      map['email'] as String,
    );
  }
}

// final userFutureRepositoryProvider = Provider((ref) => UserFutureRepository(Dio(),ref));
final userFutureRepositoryProvider = Provider.autoDispose((ref) => UserFutureRepository(Dio(),ref));

class UserFutureRepository {
  final Ref ref;
  final Dio dioClient;
  UserFutureRepository(this.dioClient, this.ref);

  Future<UserEntity> fetchUser(String input) {
    final url = 'https://jsonplaceholder.typicode.com/users/$input';
    return dioClient.get(url).then((value) {
      return UserEntity.fromMap(value.data);
    });
  }
}