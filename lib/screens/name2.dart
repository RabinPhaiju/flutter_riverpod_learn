import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/name_provider.dart';

class Name2Provider extends ConsumerWidget {
  const Name2Provider({super.key});

  void changeName(WidgetRef ref) {
    final newName = Random.secure().nextInt(100).toString();
    // ref.read(nameProvider2.notifier).state = newName;
    ref.read(nameProvider2.notifier).update((state) => newName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        const SizedBox(width: 8,),
        FilledButton(
            onPressed: () => changeName(ref),
            child: const Text('Change'))
      ]
    );
  }
}
