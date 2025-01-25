import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class ShopService {
  static Future<ShopsResponse?> getShops() async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopsResponse? shops;

    try {
      shops = await GrpcService.getShops();
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return shops;
  }
}
