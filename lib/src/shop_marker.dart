// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class ShopMarker extends StatelessWidget {
//   final _globalKey = GlobalKey();
//
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       key: _globalKey,
//       child: SafeArea(
//         child: ListView.builder(
//           itemCount: 40,
//           itemBuilder: _buildRow,
//         ),
//       ),
//     );
//   }
//
//   // RepaintBoundary の key を渡す
//   Future<Uint8List> convertWidgetToImage(GlobalKey widgetGlobalKey) async {
//     // RenderObjectを取得
//     RenderRepaintBoundary boundary = widgetGlobalKey.currentContext.findRenderObject();
//     // RenderObject を dart:ui の Image に変換する
//     ui.Image image = await boundary.toImage();
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData.buffer.asUint8List();
//   }
// }
//
