import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Util {
  static String sprintf(String template, List<dynamic> values) {
    for (var value in values) {
      template = template.replaceFirst(RegExp(r'%s|%d|%f'), value.toString());
    }
    return template;
  }

  static void showAlertDialog(
      BuildContext context, String text, String buttonLabel,
      [Function? func]) {
    // 現在のテーマからカラースキームを取得
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.primary)),
              ],
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (func != null) {
                    func();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(buttonLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.primary)),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showAppCloseDialog(
      BuildContext context, bool didPop, Object? result) async {
    if (didPop) {
      return;
    }

    // 確認ダイアログを表示
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('アプリ終了'),
        content: Text('アプリを終了しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('終了'),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }

    return;
  }
}
