import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/todo_provider.dart';

class AddTodo extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const AddTodo({super.key, required this.scrollController});

  @override
  ConsumerState<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends ConsumerState<AddTodo> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void addTodo(WidgetRef ref) {
    final title = titleController.text;
    final description = descriptionController.text;
    if(title.isEmpty || description.isEmpty){ return;}
    final id = Random.secure().nextInt(100)+1;
    ref.read(todoProvider.notifier).add(TodoModel(title, description, false, DateTime.now(), id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title',
          ),
            controller: titleController,
        ),
        const SizedBox(height: 4,),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Description',
          ),
            controller: descriptionController,
        ),
        const SizedBox(height: 4,),
        ElevatedButton(
          onPressed: (){
            addTodo(ref);
          },
          child: const Text('Add Todo'),
        )
      ]
    );
  }
}
