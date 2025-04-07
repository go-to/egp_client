import 'package:egp_client/provider/theme_notifier_provider.dart';
import 'package:egp_client/view/auth_wrapper.dart';
import 'package:egp_client/view/shop_detail_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Flutter Google Maps Sample',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      routes: <String, WidgetBuilder>{
        '/': (_) => AuthWrapper(),
        '/shop_detail': (_) => ShopDetailPage(
              year: 0,
              no: 0,
              shopId: 0,
              shopName: '',
              address: '',
            ),
      },
    );
  }
}
