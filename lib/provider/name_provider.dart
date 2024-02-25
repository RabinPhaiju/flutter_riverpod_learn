import 'package:riverpod/riverpod.dart';

// Providers
// Provider
// StateProvider
// StateNotifier & StateNotifierProvider
// FutureProvider
// StreamProvider
// AutoDisposeProvider
// AutoDisposeStateProvider
// AutoDisposeNotifierProvider
// AutoDisposeFutureProvider
// AutoDisposeStreamProvider

final nameProvider = Provider<String>((ref) => 'Flutter Learn'); // cannot change.

// for string,bool,int -> primitive
// can use class but the logic to change will lie on widgets.
final nameProvider2 = StateProvider<String>((ref) => 'Flutter Learn'); // can change.
