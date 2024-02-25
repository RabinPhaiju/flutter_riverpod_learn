import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StreamService{
  Stream<int> getStream(){
    return Stream.periodic(const Duration(seconds: 1), (value) {
      return value;
    });
  }
}

final streamServiceProvider = Provider<StreamService>((ref) => StreamService());

final streamValueProvider = StreamProvider.autoDispose((ref) async*{
  // return FirebaseFirestore.instance.collection('users').snapshots();
  ref.onDispose(() { });
  ref.onCancel(() { });
  ref.onResume(() { });
  ref.onRemoveListener(() { });
  ref.onAddListener(() { });

  final streamService = ref.watch(streamServiceProvider);
  yield* streamService.getStream();
});

class StreamProviderWidget extends ConsumerWidget {
  const StreamProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Provider'),
      ),
      body: ref.watch(streamValueProvider).when(
          data: (data){
            return Center(
              child: Text(data.toString()),
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
    );
  }
}
