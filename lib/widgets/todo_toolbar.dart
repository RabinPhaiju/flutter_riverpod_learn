import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/todo_provider.dart';

class Toolbar extends HookConsumerWidget {
  const Toolbar({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${ref.watch(uncompletedTodosCount)} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.all,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: MaterialStateProperty.all(textColorFor(TodoListFilter.all)),),
            child: const Text('All'),
          ),
          TextButton(
            onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.active,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: MaterialStateProperty.all(textColorFor(TodoListFilter.active),),
            ),
            child: const Text('Active'),
          ),
          TextButton(
            onPressed: () => ref.read(todoListFilter.notifier).state = TodoListFilter.completed,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: MaterialStateProperty.all(textColorFor(TodoListFilter.completed),),
            ),
            child: const Text('Completed'),
          ),
        ],
      ),
    );
  }
}
