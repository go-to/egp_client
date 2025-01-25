import 'package:egp_client/view/shop_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'view/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Sample',
      routes: <String, WidgetBuilder>{
        '/': (_) => Home(),
        '/shop_detail': (_) => ShopDetail(
              year: 0,
              no: 0,
              shopName: '',
              address: '',
            ),
      },
    );
  }
}
