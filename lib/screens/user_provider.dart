import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../provider/user_provider.dart';

class UserStateNotifierWidget extends ConsumerWidget {
  const UserStateNotifierWidget({super.key});

  void addUser(WidgetRef ref) {
    final newName = Random.secure().nextInt(100).toString();
    ref.read(userProvider.notifier).addUser(UserModel(newName, 0));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userProvider);
    // final user = ref.watch(userProvider.select((value) => value.age)); // only watch the age.
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: Column(
        children: [
          userList.isEmpty
              ? const Center(
                child: Text('No Data'),
              ):
              Expanded(
                child: ListView.builder(
                  itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('name:${user.name} age: ${user.age}'),
                          TextButton(
                              onPressed: (){
                                ref.read(userProvider.notifier).removeUser(user);
                              },
                              child: const Text('delete'))
                        ],
                      );
                    }
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addUser(ref),
        child: const Icon(Icons.add),
      )
    );
  }
}
