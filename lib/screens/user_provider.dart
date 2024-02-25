import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_learn/main.dart';

class UserWidget extends ConsumerWidget {
  const UserWidget({super.key});

  void changeName(WidgetRef ref) {
    final newName = Random.secure().nextInt(100).toString();
    ref.read(userProvider.notifier).updateName(newName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    // final user = ref.watch(userProvider.select((value) => value.age)); // only watch the age.
    return Center(
      child: Row(
        children: [
          Text('name:${user.name} age: ${user.age}'),
          TextButton(
            onPressed: () => changeName(ref),
            child: const Text('Change'),
          )
        ]
      ),
    );
  }
}
