import 'package:egp_client/view/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/util.dart';
import '../const/config.dart';
import '../service/auth_service.dart';

class UserNewEntryPage extends ConsumerStatefulWidget {
  const UserNewEntryPage({super.key});

  @override
  ConsumerState<UserNewEntryPage> createState() => _UserNewEntry();
}

class _UserNewEntry extends ConsumerState<UserNewEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  String? _errorMessage;

  Future<void> _entry() async {
    setState(() {
      _errorMessage = null;
    });
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      await AuthService().convertToPermanentAccount(
        email: _emailController.text,
        password: _passwordController.text,
        displayName: _usernameController.text,
      );

      // ページ遷移
      Function callback = (() => {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AuthWrapper()),
            ),
          });

      // 完了ダイアログ
      Util.showAlertDialog(
          context, Config.successEntryNewUser, Config.buttonLabelOk, callback);
    } on FirebaseAuthException catch (e) {
      String message = Config.anErrorHasOccurred;
      switch (e.code) {
        case Config.errorCodeFirebaseAuthErrorEmailAlreadyInUse:
          message = Config.thisEmailAddressIsAlreadyRegistered;
          break;
        case Config.errorCodeFirebaseAuthErrorInvalidEmail:
          message = Config.invalidEmailFormat;
          break;
        case Config.errorCodeFirebaseAuthErrorWeakPassword:
          message = Util.sprintf(Config.inputMustBeManyCharacters,
              [Config.userPassword, Config.minimumPasswordLength]);
          break;
        case Config.errorCodeFirebaseAuthErrorInvalidDisplayNameLength:
          message = Util.sprintf(Config.inputMustBeManyCharacters,
              [Config.userDisplayName, Config.minimumDisplayNameLength]);
          break;
      }
      setState(() {
        _errorMessage = message;
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
          title: Text(Config.userNewEntryPageTitle),
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
          child: Form(
            key: _formKey,
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
                  validator: (value) => value!.contains(Config
                          .charactersThatDetermineWhetherAnEmailAddressIsValid)
                      ? null
                      : Config.pleaseEnterAValidEmail,
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
                  validator: (value) => value!.length >=
                          Config.minimumPasswordLength
                      ? null
                      : Util.sprintf(Config.inputMustBeManyCharacters,
                          [Config.userPassword, Config.minimumPasswordLength]),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration:
                      inputDecoration(Config.userDisplayName, colorScheme),
                  validator: (value) =>
                      value!.length >= Config.minimumDisplayNameLength
                          ? null
                          : Util.sprintf(Config.inputMustBeManyCharacters, [
                              Config.userDisplayName,
                              Config.minimumDisplayNameLength
                            ]),
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
                  onPressed: _entry,
                  child: const Text(Config.entryNewUser),
                ),
              ],
            ),
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
