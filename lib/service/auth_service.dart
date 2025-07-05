import 'package:firebase_auth/firebase_auth.dart';

import '../common/util.dart';
import '../const/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
class AuthService extends _$AuthService {
  @override
  AuthService build() => AuthService();

  Future<void> signInAnonymously() async {
    try {
      FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(Util.sprintf(
          Config.errorDetail, [Config.failedToAnonymousSignIn, e]));
      throw FirebaseAuthException(
        code: Config.errorCodeFirebaseAuthErrorFailedSignInAnonymously,
        message: Config.failedToAnonymousSignIn,
      );
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(Util.sprintf(Config.errorDetail, [Config.failedToSignIn, e]));
      throw FirebaseAuthException(
        code: Config.errorCodeFirebaseAuthErrorFailedSignIn,
        message: Config.failedToSignIn,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(Util.sprintf(Config.errorDetail, [Config.failedToSignOut, e]));
      throw FirebaseAuthException(
        code: Config.errorCodeFirebaseAuthErrorFailedSignOut,
        message: Config.failedToSignOut,
      );
    }
  }

  // 現在のユーザーを取得
  User? getCurrentUser() {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      return currentUser;
    } catch (e) {
      print(Util.sprintf(
          Config.errorDetail, [Config.failedToGetAnonymousUserInformation, e]));
      throw FirebaseAuthException(
        code: Config.errorCodeFirebaseAuthErrorFailedGetCurrentUser,
        message: Config.failedToGetAnonymousUserInformation,
      );
    }
  }

  // 匿名ユーザーから永続ユーザーへの昇格処理
  Future<void> convertToPermanentAccount({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null || !currentUser.isAnonymous) {
      throw Exception(Config.anonymousUserDoesNotExist);
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await currentUser.linkWithCredential(credential);
    await currentUser.updateDisplayName(displayName);
    await currentUser.reload();
  }
}
