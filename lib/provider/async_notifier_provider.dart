import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/provider/todo_provider.dart';
import 'package:dio/dio.dart';

class TodoAsyncNotifierProvider extends AutoDisposeAsyncNotifier<List<TodoModel>> {
  @override
  FutureOr<List<TodoModel>> build() async {
    final json = await Dio().get('api/todos');

    return [...json.data.map(TodoModel.fromMap)];
  }

  Future<void> addTodo(TodoModel todo) async {
    final json = await Dio().post('api/todos');
    final List<TodoModel> newTodos = [...json.data.map(TodoModel.fromMap)];
    state = AsyncData(newTodos);
  }
}

final todoAsyncNotifierProvider = AsyncNotifierProvider.autoDispose<TodoAsyncNotifierProvider, int>(TodoAsyncNotifierProvider.new);