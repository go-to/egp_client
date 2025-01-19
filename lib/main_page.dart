import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'egp_map.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ヱビスビールに合う逸品グランプリ"),
      ),
      body: Center(
        child: EgpMap(),
      ),
    );
  }
}
