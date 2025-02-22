import 'package:egp_client/service/shop_service.dart';
import 'package:egp_client/service/stamp_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stamp_provider.g.dart';

@riverpod
class Stamp extends _$Stamp {
  @override
  Future<int> build(String userId, int shopId) async {
    return await getStampNum(userId, shopId);
  }

  Future<int> getStampNum(String userId, int shopId) async {
    final shops = await ShopService.getShops(userId);
    for (final shop in shops!.shops) {
      if (shop.iD == shopId) {
        return shop.numberOfTimes;
      }
    }
    return 0;
  }

  Future<int> addStamp(String userId, int shopId) async {
    final stamp = await StampService.addStamp(userId, shopId);
    state = AsyncData(stamp!.numberOfTimes);
    return stamp.numberOfTimes;
  }

  Future<int> deleteStamp(String userId, int shopId) async {
    final stamp = await StampService.deleteStamp(userId, shopId);
    state = AsyncData(stamp!.numberOfTimes);
    return stamp.numberOfTimes;
  }
}
