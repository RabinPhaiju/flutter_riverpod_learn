import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/screens/name2.dart';
import 'package:flutter_riverpod_learn/screens/statefull_ref.dart';
import 'package:flutter_riverpod_learn/screens/stream_provider.dart';
import 'package:flutter_riverpod_learn/screens/user_future_ref.dart';
import 'package:flutter_riverpod_learn/screens/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const STATEFULLREF(),
      ),
      body: Center(
        child: Column(
          children: [
            Name2Provider(),
            UserWidget(),
            UserFutureWidget(),
            StreamProviderWidget()
            ],
        ),
      ),
    );
  }
}
