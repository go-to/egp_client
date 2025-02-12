import 'package:firebase_auth/firebase_auth.dart';

import '../provider/firebase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  @override
  AuthService build() => AuthService();

  Future<void> signInAnonymously() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.signInAnonymously();
    } catch (e) {
      print('匿名ログインに失敗しました: $e');
    }
  }

  Future<void> signOut() async {
    try {
      final auth = ref.read(firebaseAuthProvider);
      await auth.signOut();
    } catch (e) {
      print('ログアウトに失敗しました: $e');
    }
  }

  // 現在のユーザーを取得
  User? getCurrentUser() {
    try {
      final auth = ref.read(firebaseAuthProvider);
      return auth.currentUser;
    } catch (e) {
      print('匿名ユーザー情報の取得に失敗しました: $e');
    }
    return null;
  }
}
