import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/firebase_provider.dart';
import '../service/auth_service.dart';
import 'home_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // ユーザーが未ログインの場合、匿名認証を実行
          ref.read(authServiceProvider.notifier).signInAnonymously();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          // ログイン済みの場合、ホーム画面へ遷移
          return const HomePage();
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('エラーが発生しました：$error')),
      ),
    );
  }
}
