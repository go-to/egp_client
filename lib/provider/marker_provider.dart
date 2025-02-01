import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'marker_provider.g.dart';

// 選択されたマーカーの状態を管理するプロバイダ
@riverpod
class SelectedMarker extends _$SelectedMarker {
  @override
  MarkerId? build() => null;

  void selectMarker(MarkerId markerId) {
    state = markerId;
  }

  void clearSelection() {
    state = null;
  }
}
