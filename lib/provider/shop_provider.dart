import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:egp_client/service/shop_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_provider.g.dart';

@riverpod
class Shop extends _$Shop {
  @override
  Future<ShopsResponse?> build() async {
    return await _fetchShops();
  }

  Future<ShopsResponse?> _fetchShops() {
    return ShopService.getShops();
  }

  Future<ShopsResponse?> getShops([List<int>? searchCondition]) async {
    final shops = await ShopService.getShops(searchCondition);
    state = AsyncData(shops);
    return shops;
  }
}
