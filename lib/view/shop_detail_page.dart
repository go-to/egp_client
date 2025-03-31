import 'package:egp_client/provider/stamp_provider.dart';
import 'package:egp_client/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../const/config.dart';

class ShopDetailPage extends ConsumerStatefulWidget {
  final int year;
  final int no;
  final int shopId;
  final String shopName;
  final String address;

  const ShopDetailPage({
    super.key,
    required this.year,
    required this.no,
    required this.shopId,
    required this.shopName,
    required this.address,
  });

  @override
  ConsumerState<ShopDetailPage> createState() => _ShopPageDetail();
}

class _ShopPageDetail extends ConsumerState<ShopDetailPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    final String webViewUrl =
        '${Config.eventBaseUrl}/${widget.year}/${widget.no}';
    final String webViewName = 'test';
    _controller = WebViewController()
      ..loadRequest(Uri.parse(webViewUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        webViewName,
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authServiceProvider.notifier).getCurrentUser();
    final userId = user!.uid;
    final shopId = widget.shopId;
    final stampNumAsync = ref.watch(StampProvider(userId, shopId));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.no}: ${widget.shopName}'),
          automaticallyImplyLeading: false,
          // 戻るアイコン
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () async {
                // 現在のURLを取得してクリップボードにコピー
                String? currentUrl = await _controller.currentUrl();
                if (currentUrl != null) {
                  Clipboard.setData(ClipboardData(text: currentUrl));
                  String message = 'URLをコピーしました: $currentUrl';
                  _showTopSnackBar(context, message);
                }
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Positioned(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(110, 60),
                      maximumSize: Size(110, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _launchMap();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_sharp, size: 30.0),
                        SizedBox(height: 4),
                        Text('地図を開く', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            stampNumAsync.when(
              data: (int stampNum) {
                return Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(StampProvider(userId, shopId).notifier)
                              .addStamp(userId, shopId);
                        },
                        child: Text(
                            stampNum > 0 ? '獲得済み(${stampNum}個)' : 'スタンプを獲得する'),
                      ),
                      // TODO 別メニューに移動する
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(StampProvider(userId, shopId).notifier)
                              .deleteStamp(userId, shopId);
                        },
                        child: Text('スタンプ取り消し'),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object error, StackTrace stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          elevation: 4.0,
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(2.0),
            color: Color.fromRGBO(161, 152, 34, 0.9),
            child: SafeArea(
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    // Overlayに追加
    overlay.insert(overlayEntry);

    // 数秒後に削除
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  Future<void> _launchMap() async {
    String searchQuery = Uri.encodeFull(
        '恵比寿 ${widget.shopName} ${widget.address}'.replaceAll('&', ' '));
    final googleMapsUrl = Uri.parse('comgooglemaps://?q=${searchQuery}');
    final appleMapsUrl = Uri.parse('http://maps.apple.com/?q=${searchQuery}');
    final browserUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${searchQuery}');

    // Google Mapsアプリがインストールされているか確認
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    }
    // iPhoneのデフォルトマップアプリ（Apple Maps）を起動
    else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    }
    // ブラウザでGoogle Mapsを開く
    else if (await canLaunchUrl(browserUrl)) {
      await launchUrl(browserUrl);
    } else {
      // どれも起動できない場合のエラーメッセージ
      print('マップを開けませんでした');
    }
  }
}
