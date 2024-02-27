import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learn/widgets/add_todo.dart';
import '../provider/todo_provider.dart';

class TodoStateNotifierWidget extends ConsumerWidget {
  const TodoStateNotifierWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(todoProvider);
    // final user = ref.watch(userProvider.select((value) => value.age)); // only watch the age.
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: Column(
        children: [
          userList.isEmpty
              ? const Center(
                child: Text('No Data'),
              ):
              Expanded(
                child: ListView.builder(
                  itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final todo = userList[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(todo.title,),
                                  Text(todo.description),
                                  Text(todo.dateTime.toString()),
                                ]
                              ),
                              TextButton(
                                  onPressed: (){
                                    ref.read(todoProvider.notifier).remove(todo);
                                  },
                                  child: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getDddTodoSheet(context),
        child: const Icon(Icons.add),
      )
    );
  }

  void getDddTodoSheet(BuildContext context){
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
