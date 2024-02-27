import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learn/widgets/add_todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../provider/todo_provider.dart';
import '../widgets/todo_item.dart';
import '../widgets/todo_toolbar.dart';

class TodoStateNotifierWidget extends HookConsumerWidget {
  const TodoStateNotifierWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final todoList = ref.watch(userProvider.select((value) => value.age)); // only watch the age.
    // final todoList = ref.watch(todoProvider);
    final todoList = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifier Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Toolbar(),
            todoList.isEmpty
              ? TextField(
                  controller: newTodoController,
                  decoration: const InputDecoration(
                    labelText: 'What needs to be done?',
                  ),
                  onSubmitted: (value) {
                    final title = value;
                    final description = value;
                    if(title.isEmpty || description.isEmpty){ return;}
                    final id = Random.secure().nextInt(100)+1;
                    ref.read(todoProvider.notifier).add(TodoModel(title, description, false, DateTime.now(), id));
                    newTodoController.clear();
                  },
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[index];
                        return  Dismissible(
                          key: ValueKey(todo.id),
                          onDismissed: (_) {
                            ref.read(todoProvider.notifier).remove(todo.id);
                          },
                          child: ProviderScope(
                            overrides: [ currentTodo.overrideWithValue(todo), ],
                            child: const TodoItem(),
                          ),
                        );
                      }
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getTodoSheet(context),
        child: const Icon(Icons.add),
      )
    );
  }

  void getTodoSheet(BuildContext context){
    showModalBottomSheet(
        useSafeArea: true,
        showDragHandle: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        context: context,
        builder: (bCtx){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(bCtx).viewInsets.bottom),
            child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.80,
                maxChildSize: 1,
                minChildSize: 0.60,
                builder: (context,scrollController){
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: AddTodo(scrollController: scrollController),
                  );
                }
            ),
          );
        }
    );
  }
}
