import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/grpc_service.dart';

final shopProvider =
    StateNotifierProvider<ShopNotifier, Map<String, Shop>>((ref) {
  return ShopNotifier();
});

class ShopNotifier extends StateNotifier<Map<String, Shop>> {
  ShopNotifier() : super({});

  Future<ShopsResponse?> getShops() async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopsResponse? shops;
    try {
      shops = await GrpcService.getShops();
    } catch (e) {
      print('Caught error: $e');
      return null;
    } finally {
      channel.shutdown();
    }

    return shops;
  }

  Future<Map<String, Shop>> setShops() async {
    final shops = await getShops();

    for (var shop in shops!.shops) {
      state[shop.iD.toString()] = shop;
    }
    state = {...state};
    return state;
  }
}
