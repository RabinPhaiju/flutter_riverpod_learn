import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/provider/future_provider.dart';
import 'package:flutter_riverpod_learn/provider/user_provider.dart';
import 'package:flutter_riverpod_learn/screens/homepage.dart';

// expose stateNotifier
final userProvider = StateNotifierProvider<UserModelNotifier, UserModel>((ref) {
  return UserModelNotifier();
});

// future Provider
// final userFutureProvider = FutureProvider<UserFuture>((ref) {
//   // return UserFutureRepository(http.Client()).fetchUser();
//   final userRepository = ref.watch(userFutureRepositoryProvider);
//   return userRepository.fetchUser();
// });

// future Provider
final userFutureProvider = FutureProvider.family.autoDispose((ref,String input) {
  // return UserFutureRepository(http.Client()).fetchUser();
  final userRepository = ref.watch(userFutureRepositoryProvider);
  return userRepository.fetchUser(input);
});

final streamProvider = StreamProvider.autoDispose((ref) async*{
  ref.onDispose(() { });
  ref.onCancel(() { });
  ref.onResume(() { });
  ref.onRemoveListener(() { });
  ref.onAddListener(() { });
  // return FirebaseFirestore.instance.collection('users').snapshots();
    yield([1,2,3,4]);
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}