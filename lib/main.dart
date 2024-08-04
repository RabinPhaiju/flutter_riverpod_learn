import 'package:flutter_riverpod_learn/services/database_service.dart';
import 'package:flutter_riverpod_learn/services/http_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_learn/screens/homepage.dart';

void main()async{
 await _setupServices();

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _setupServices() async {
  GetIt.instance.registerSingleton<HTTPService>(HTTPService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
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