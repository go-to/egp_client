import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';

import '../common/util.dart';
import '../const/config.dart';
import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class StampService {
  static Future<StampResponse?> addStamp(
      BuildContext context, String userId, int shopId) async {
    final channel = GrpcService.getChannel();
    StampResponse? stamp;

    try {
      stamp = await GrpcService.addStamp(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(context, 'スタンプ獲得に失敗しました', Config.buttonLabelClose);
    } catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(context, 'スタンプ獲得に失敗しました', Config.buttonLabelClose);
    } finally {
      channel.shutdown();
    }

    return stamp;
  }

  static Future<StampResponse?> deleteStamp(
      BuildContext context, String userId, int shopId) async {
    final channel = GrpcService.getChannel();
    StampResponse? stamp;

    try {
      stamp = await GrpcService.deleteStamp(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(context, 'スタンプ取り消しに失敗しました', Config.buttonLabelClose);
    } catch (e) {
      print('Caught error: $e');
      Util.showAlertDialog(context, 'スタンプ取り消しに失敗しました', Config.buttonLabelClose);
    } finally {
      channel.shutdown();
    }

    return stamp;
  }
}
