import 'package:flutter/material.dart';
import 'egp_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Sample',
      home: EgpMap(),
    );
  }
}
