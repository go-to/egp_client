import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_notifier_provider.g.dart';

// Riverpodの状態管理プロバイダー
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('theme_mode') ?? ThemeMode.system.index;
    return ThemeMode.values[savedIndex];
  }

  Future<void> updateTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
    state = AsyncValue.data(mode);
  }
}
