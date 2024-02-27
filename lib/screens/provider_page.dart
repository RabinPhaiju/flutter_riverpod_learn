import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nameProvider = Provider<String>((ref) => 'Flutter Learn'); // cannot change.

class ProviderPage extends ConsumerStatefulWidget {
  const ProviderPage({super.key});

  @override
  ConsumerState<ProviderPage> createState() => _ProviderPageState();
}

class _ProviderPageState extends ConsumerState<ProviderPage> {
  String name = '';

  @override
  void initState() {
    name = ref.read(nameProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Page'),
      ),
        body: Center(child: Text(name)));
  }
}
