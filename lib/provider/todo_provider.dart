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
  List<TodoModel> build(){
    return [
      TodoModel('title1', 'description1', false, DateTime.now(), 1)
    ]; // call local db or network.
  }

  void add(TodoModel todo) {
    state = [todo,...state];
  }

 void remove(int id) {
    state = state.where((element) => element.id != id).toList();
  }

  void update(int id, String description) {
    state = state.map((e) => e.id == id ? e.copyWith(description: description) : e).toList();
  }

  void toggle(int id) {
    state = state.map((e) => e.id == id ? e.copyWith(isComplete: !e.isComplete) : e).toList();
  }

  void clear() {
    state.clear();
  }
}

// expose Notifier
// here as a `List<TodoModel>` is a complex object, with advanced business logic like how to edit a todo.
final todoProvider = NotifierProvider.autoDispose<TodoModelNotifier, List<TodoModel>>(TodoModelNotifier.new);

enum TodoListFilter { all, active, completed, }
/// here is no fancy logic behind manipulating the value since it's just enum.
final todoListFilter = StateProvider.autoDispose((_) => TodoListFilter.all); // default value is all.

/// By using [Provider], this value is cached, making it performant.Even multiple widgets try to read the number of uncompleted todos,
/// the value will be computed only once (until the todo-list changes).
/// This will also optimise unneeded rebuilds if the todo-list changes, but the number of uncompleted todos doesn't (such as when editing a todo).
final uncompletedTodosCount = Provider.autoDispose<int>((ref) {
  return ref.watch(todoProvider).where((todo) => !todo.isComplete).length;
});

/// This too uses [Provider], to avoid recomputing the filtered list unless either the filter of or the todo-list updates.
final filteredTodos = Provider.autoDispose<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter); // if used watcher, it will be recomputed when todoListFilter changes.
  final todos = ref.watch(todoProvider); // if used watcher, it will be recomputed when todoList changes.

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.isComplete).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.isComplete).toList();
    case TodoListFilter.all:
      return todos;
  }
});
