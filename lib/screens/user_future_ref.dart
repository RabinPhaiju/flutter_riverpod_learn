import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';

class UserFutureWidget extends ConsumerWidget {
  const UserFutureWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(userFutureProvider).map(data: data, error: error, loading: loading)
    return ref.watch(userFutureProvider('3')).when(// change '3' with input and setState
        data: (data){
          return Center(
            child: Text(data.name),
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
        });
  }
}
