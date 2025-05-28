import 'package:egp_client/service/auth_service.dart';
import 'package:egp_client/view/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/util.dart';
import '../const/config.dart';

class UserSignInPage extends ConsumerStatefulWidget {
  const UserSignInPage({super.key});

  @override
  ConsumerState<UserSignInPage> createState() => _UserSignIn();
}

class _UserSignIn extends ConsumerState<UserSignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _signIn() async {
    setState(() {
      _errorMessage = null;
    });
    try {
      await AuthService().signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // TODO ログイン前の匿名ユーザーのスタンプをログインユーザーのスタンプに合算

      // ページ遷移
      Function callback = (() => {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AuthWrapper()),
            ),
          });

      // 完了ダイアログ
      Util.showAlertDialog(
          context, Config.successSignInUser, Config.buttonLabelOk, callback);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 現在のテーマからカラースキームを取得
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Config.userSignInPageTitle),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: inputDecoration(Config.userEmail, colorScheme),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(Config.userInputEnableRegExp),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: inputDecoration(Config.userPassword, colorScheme),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(Config.userInputEnableRegExp),
                  ),
                ],
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _signIn,
                child: const Text(Config.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label, ColorScheme colorScheme) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.6),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.6),
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
      labelText: label,
      labelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(
            fontSize: Config.fontSizeNormal,
            color: Colors.red,
          );
        }
        return TextStyle(
          fontSize: Config.fontSizeNormal,
          color: colorScheme.primary.withValues(alpha: 0.8),
        );
      }),
      errorStyle: TextStyle(
        fontSize: Config.fontSizeNormal,
        color: Colors.red,
      ),
      floatingLabelStyle: TextStyle(fontSize: Config.fontSizeNormal),
    );
  }
}
