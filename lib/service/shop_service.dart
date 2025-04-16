import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';

import '../common/util.dart';
import '../const/config.dart';
import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class ShopService {
  static Future<ShopsResponse?> getShops(BuildContext context, String userId,
      [List<int>? searchCondition, String? searchKeyword]) async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopsResponse? shops;

    try {
      final searchParams = searchCondition ?? [];
      shops = await GrpcService.getShops(userId, searchParams, searchKeyword);
    } on GrpcError catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(
          context, Config.failedToGetShopInformation, Config.buttonLabelClose);
    } catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(
          context, Config.failedToGetShopInformation, Config.buttonLabelClose);
    } finally {
      channel.shutdown();
    }

    return shops;
  }

  static Future<ShopResponse?> getShop(
      BuildContext context, String userId, int shopId) async {
    // 店舗情報を取得
    final channel = GrpcService.getChannel();
    ShopResponse? shop;

    try {
      shop = await GrpcService.getShop(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(
          context, Config.failedToGetShopInformation, Config.buttonLabelClose);
    } catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(
          context, Config.failedToGetShopInformation, Config.buttonLabelClose);
    } finally {
      channel.shutdown();
    }

    return shop;
  }
}
