import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class UserModel {
  final String name;
  final int age;

  const UserModel(this.name, this.age);

  UserModel copyWith({String? name, int? age}) {
    return UserModel(name ?? this.name, age ?? this.age);
  }

  @override
  String toString() {
    return 'UserModel(name: $name, age: $age)';
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  //fromMap
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] as String,
      map['age'] as int,
    );
  }

  // copyWith
  UserModel copyWith2({String? name, int? age}) {
    return UserModel(name ?? this.name, age ?? this.age);
  }

}

class UserModelNotifier extends StateNotifier<List<UserModel>> {
  // UserModelNotifier(super.state);
  UserModelNotifier() : super([]);

  void addUser(UserModel user) {
    state = [...state, user];
  }

  void removeUser(UserModel user) {
    state = state.where((element) => element.name != user.name).toList();
  }

  void clear() {
    state = [];
  }
}

// expose stateNotifier
final userProvider = StateNotifierProvider.autoDispose<UserModelNotifier, List<UserModel>>((ref) {
  return UserModelNotifier();
});
