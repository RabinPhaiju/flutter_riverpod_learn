import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool isComplete;
  final DateTime dateTime;

  const TodoModel(this.title, this.description, this.isComplete, this.dateTime, this.id);


  // copyWith
  TodoModel copyWith({int? id, String? title, String? description, bool? isComplete, DateTime? dateTime}) {
    return TodoModel(
      title ?? this.title,
      description ?? this.description,
      isComplete ?? this.isComplete,
      dateTime ?? this.dateTime,
      id ?? this.id,
    );
  }

  //fromMap
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      map['title'] as String,
      map['description'] as String,
      map['isComplete'] as bool,
      DateTime.parse(map['dateTime']),
      map['id'] as int,
    );
  }
}

class TodoModelNotifier extends AutoDisposeNotifier<List<TodoModel>> {
  @override
  List<TodoModel> build() => [];

  void add(TodoModel todo) {
    state = [todo,...state];
  }

 void remove(TodoModel todo) {
    state = state.where((element) => element.id != todo.id).toList();
  }

  void update(TodoModel todo) {
    state = state.map((e) => e.id == todo.id ? todo : e).toList();
  }


  void clear() {
    state = [];
  }
}

// expose stateNotifier
final todoProvider = NotifierProvider.autoDispose<TodoModelNotifier, List<TodoModel>>(TodoModelNotifier.new);


// class TodoModelNotifier extends StateNotifier<List<TodoModel>> {
//   // TodoModelNotifier(super.state);
//   TodoModelNotifier() : super([]);
//
//   void addTodo(TodoModel todo) {
//     state = [todo,...state];
//   }
//
//  void removeTodo(TodoModel todo) {
//     state = state.where((element) => element.id != todo.id).toList();
//   }
//
//   void clear() {
//     state = [];
//   }
// }
//
// // expose stateNotifier
// final todoProvider = StateNotifierProvider.autoDispose<TodoModelNotifier, List<TodoModel>>((ref) {
//   return TodoModelNotifier();
// });
