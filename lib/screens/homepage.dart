import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/screens/pokemon/pokemon_page.dart';
import 'package:flutter_riverpod_learn/screens/provider_page.dart';
import 'package:flutter_riverpod_learn/screens/state_provider_page.dart';
import 'package:flutter_riverpod_learn/screens/stream_provider.dart';
import 'package:flutter_riverpod_learn/screens/user_future_ref.dart';
import 'package:flutter_riverpod_learn/screens/todo_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderPage()));},
                child: const Text('Provider')
            ),
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const StateProviderPage()));},
                child: const Text('State Provider')
            ),
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const FutureProviderPage()));},
                child: const Text('Future Provider')
            ),
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const StreamProviderWidget()));},
                child: const Text('Stream Provider')
            ),
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const  TodoStateNotifierWidget()));},
                child: const Text('Notifier Provider')
            ),
            ElevatedButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const  PokemonPage()));},
                child: const Text('Pokemon Page')
            ),

            ],
        ),
      ),
    );
  }
}
