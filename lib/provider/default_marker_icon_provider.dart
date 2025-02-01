import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../const/config.dart';

part 'default_marker_icon_provider.g.dart';

// マーカーアイコン（デフォルト）
@riverpod
Future<BitmapDescriptor> defaultMarkerIconOpen(
    DefaultMarkerIconOpenRef ref) async {
  return BitmapDescriptor.asset(
    const ImageConfiguration(),
    Config.shopOpenImagePath,
    width: Config.shopImageWidth,
    height: Config.shopImageHeight,
  );
}

@riverpod
Future<BitmapDescriptor> defaultMarkerIconClose(
    DefaultMarkerIconCloseRef ref) async {
  return BitmapDescriptor.asset(
    const ImageConfiguration(),
    Config.shopCloseImagePath,
    width: Config.shopImageWidth,
    height: Config.shopImageHeight,
  );
}
