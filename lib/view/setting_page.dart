import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/util.dart';
import '../const/config.dart';
import '../provider/theme_notifier_provider.dart';
import '../service/auth_service.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider).value;
    // 現在のテーマからカラースキームを取得
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.read(authServiceProvider.notifier).getCurrentUser();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Util.showAppCloseDialog(context, didPop, result);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(Config.settingPageTitle)),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // アカウント設定
            Card(
              shadowColor: colorScheme.primary,
              surfaceTintColor: colorScheme.primary.withAlpha(0),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: colorScheme.primary),
                        SizedBox(width: 8),
                        Text(Config.settingItemAccount,
                            style: TextStyle(
                                fontSize: Config.fontSizeMediumLargeMiddle,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16),
                    if (user!.isAnonymous) ...{
                      ElevatedButton(
                        child: Text(Config.accountNewEntry),
                        onPressed: () {
                          // TODO 新規登録処理
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text(Config.accountLogin),
                        onPressed: () {
                          // TODO ログイン処理
                        },
                      ),
                    } else ...{
                      ListTile(
                        title: Text(Config.accountNickname),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8, left: 2),
                          child: Text(
                            user.displayName.toString(),
                            style: TextStyle(
                                color:
                                    colorScheme.primary.withValues(alpha: 0.6)),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(Config.accountEmail),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8, left: 2),
                          child: Text(
                            user.email.toString(),
                            style: TextStyle(
                                color:
                                    colorScheme.primary.withValues(alpha: 0.6)),
                          ),
                        ),
                      ),
                      // TODO ログアウト
                    }
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // テーマ設定
            Card(
              shadowColor: colorScheme.primary,
              surfaceTintColor: colorScheme.primary.withAlpha(0),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.color_lens, color: colorScheme.primary),
                        SizedBox(width: 8),
                        Text(Config.settingItemTheme,
                            style: TextStyle(
                                fontSize: Config.fontSizeMediumLargeMiddle,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 16),
                    RadioListTile<ThemeMode>(
                      title: const Text(Config.themeLight),
                      value: ThemeMode.light,
                      groupValue: currentTheme,
                      onChanged: (mode) => ref
                          .read(themeNotifierProvider.notifier)
                          .updateTheme(mode!),
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text(Config.themeDark),
                      value: ThemeMode.dark,
                      groupValue: currentTheme,
                      onChanged: (mode) => ref
                          .read(themeNotifierProvider.notifier)
                          .updateTheme(mode!),
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text(Config.themeSystemSetting),
                      value: ThemeMode.system,
                      groupValue: currentTheme,
                      onChanged: (mode) => ref
                          .read(themeNotifierProvider.notifier)
                          .updateTheme(mode!),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
