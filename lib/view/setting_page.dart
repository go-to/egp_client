import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/theme_notifier_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('設定画面')),
      body: Column(
        children: [
          ListTile(
            title: const Text('ライトモード'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: ref.watch(themeNotifierProvider),
              onChanged: (mode) => themeNotifier.toggleTheme(mode!),
            ),
          ),
          ListTile(
            title: const Text('ダークモード'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: ref.watch(themeNotifierProvider),
              onChanged: (mode) => themeNotifier.toggleTheme(mode!),
            ),
          ),
          ListTile(
            title: const Text('システム設定に従う'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: ref.watch(themeNotifierProvider),
              onChanged: (mode) => themeNotifier.toggleTheme(mode!),
            ),
          ),
        ],
      ),
    );
  }
}
