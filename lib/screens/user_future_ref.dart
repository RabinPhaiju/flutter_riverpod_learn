import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/future_provider.dart';

// future Provider
// final userFutureProvider = FutureProvider<UserEntity>((ref) {
//   final userRepository = ref.watch(userFutureRepositoryProvider);
//   return userRepository.fetchUser('1');
// });

// future provider with dispose
final userFutureProvider = FutureProvider.family.autoDispose((ref,String input) {
  final userRepository = ref.watch(userFutureRepositoryProvider);
  return userRepository.fetchUser(input);
});

class FutureProviderPage extends ConsumerStatefulWidget {
  const FutureProviderPage({super.key});

  @override
  ConsumerState<FutureProviderPage> createState() => _FutureProviderPageState();
}

class _FutureProviderPageState extends ConsumerState<FutureProviderPage> {
  String userId = '1';

  @override
  Widget build(BuildContext context) {
    final userRef = ref.watch(userFutureProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          int id = Random().nextInt(10) + 1;
          setState(() {
            userId = id.toString();
          });
        },
        child: userRef.when(// change '3' with input and setState
            data: (data){
              return ListView(
                children: [
                  Text(data.name,style: const TextStyle(fontSize: 20),),
                ]
              );
            },
            error: (error, stackTrace){
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: (){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
