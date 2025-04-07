import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'theme_notifier_provider.g.dart';

// Riverpodの状態管理プロバイダー
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  ThemeMode build() => _themeMode;

  void toggleTheme(ThemeMode mode) {
    _themeMode = mode;
    state = _themeMode;
  }
}
