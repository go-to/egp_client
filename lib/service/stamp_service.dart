import 'package:grpc/grpc.dart';

import '../grpc_gen/egp.pbgrpc.dart';
import 'grpc_service.dart';

class StampService {
  static Future<StampResponse?> addStamp(String userId, int shopId) async {
    final channel = GrpcService.getChannel();
    StampResponse? stamp;

    try {
      stamp = await GrpcService.addStamp(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return stamp;
  }

  static Future<StampResponse?> deleteStamp(String userId, int shopId) async {
    final channel = GrpcService.getChannel();
    StampResponse? stamp;

    try {
      stamp = await GrpcService.deleteStamp(userId, shopId);
    } on GrpcError catch (e) {
      print('Caught error: $e');
    } catch (e) {
      print('Caught error: $e');
    } finally {
      channel.shutdown();
    }

    return stamp;
  }
}
