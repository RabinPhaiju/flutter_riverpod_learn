import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/name_provider.dart';

class STATEFULLREF extends ConsumerStatefulWidget {
  const STATEFULLREF({super.key});

  @override
  ConsumerState<STATEFULLREF> createState() => _STATEFULLREFState();
}

class _STATEFULLREFState extends ConsumerState<STATEFULLREF> {
  String name = '';

  @override
  void initState() {
    name = ref.read(nameProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
