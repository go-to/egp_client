import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grpc/grpc.dart';
import 'package:egp_client/grpc_gen/egp.pbgrpc.dart';

class GrpcEgpService {
  static ClientChannel getChannel() {
    return ClientChannel(
      dotenv.get('GRPC_SERVER_HOST'),
      port: int.parse(dotenv.get('GRPC_SERVER_PORT')),
      // default: secure()
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  static Future<ShopsResponse> getShops() async {
    final channel = getChannel();
    final client = EgpServiceClient(channel);
    final res = await client.getShops(
      ShopsRequest(),
    );
    return res;
  }
}
