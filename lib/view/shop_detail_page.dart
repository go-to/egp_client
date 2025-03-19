import 'package:egp_client/provider/stamp_provider.dart';
import 'package:egp_client/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
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
}
