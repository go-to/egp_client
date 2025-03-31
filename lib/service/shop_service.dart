import 'package:grpc/grpc.dart';

import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class ShopService {
  static Future<ShopsResponse?> getShops(String userId,
      [List<int>? searchCondition, String? searchKeyword]) async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopsResponse? shops;

    try {
      final searchParams = searchCondition ?? [];
      shops = await GrpcService.getShops(userId, searchParams, searchKeyword);
    } on GrpcError catch (e) {
      print('Caught error: $e');
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return shops;
  }

  static Future<ShopResponse?> getShop(String userId, int shopId) async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopResponse? shop;

    try {
      shop = await GrpcService.getShop(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return shop;
  }
}
