import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class ShopService {
  static Future<ShopsResponse?> getShops([List<int>? searchCondition]) async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopsResponse? shops;

    try {
      final searchParams = searchCondition ?? [];
      shops = await GrpcService.getShops(searchParams);
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return shops;
  }
}
