import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/util.dart';
import '../const/config.dart';
import '../provider/theme_notifier_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider).value;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Util.showAppCloseDialog(context, didPop, result);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(Config.settingPageTitle)),
        body: Column(
          children: [
            RadioListTile<ThemeMode>(
              title: const Text(Config.themeLight),
              value: ThemeMode.light,
              groupValue: currentTheme,
              onChanged: (mode) =>
                  ref.read(themeNotifierProvider.notifier).updateTheme(mode!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text(Config.themeDark),
              value: ThemeMode.dark,
              groupValue: currentTheme,
              onChanged: (mode) =>
                  ref.read(themeNotifierProvider.notifier).updateTheme(mode!),
            ),
            RadioListTile<ThemeMode>(
              title: const Text(Config.themeSystemSetting),
              value: ThemeMode.system,
              groupValue: currentTheme,
              onChanged: (mode) =>
                  ref.read(themeNotifierProvider.notifier).updateTheme(mode!),
            ),
          ],
        ),
      ),
    );
  }
}
