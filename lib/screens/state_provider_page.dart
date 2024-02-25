import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// for string,bool,int -> primitive
// can use class but the logic to change will lie on widgets.
final valueStateProvider = StateProvider<String>((ref) => 'Riverpod state provider'); // can change.
// final valueStateProvider = StateProvider.autoDispose<String>((ref) => 'Riverpod state provider'); // can change.


class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});

  void changeName(WidgetRef ref) {
    final newName = Random.secure().nextInt(100).toString();
    // ref.read(valueStateProvider.notifier).state = newName;
    ref.read(valueStateProvider.notifier).update((state) => newName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(valueStateProvider);
     // only calls when state changes. not when it is initialized.
    ref.listen<String>(valueStateProvider,(prev,curr){
      if(curr == '0'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(curr),
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              const SizedBox(width: 8,),
              FilledButton(
                  onPressed: () => changeName(ref),
                  child: const Text('Change'))
            ]
        ),
      ),
    );
  }
}
