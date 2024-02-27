import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nameProvider = Provider.autoDispose<String>((ref) => throw UnimplementedError()); // cannot change.

class ProviderPage extends ConsumerWidget {
  const ProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final name = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Page'),
      ),
        body: Center(child: ProviderScope(
          overrides: [
            nameProvider.overrideWithValue('name'),
          ],
            child: const Test()
        )),
    );
  }
}

class Test extends ConsumerWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);
    return Text(name);
  }
}

