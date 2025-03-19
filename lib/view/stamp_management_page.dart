import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:egp_client/service/grpc_service.dart';
import 'package:egp_client/view/shop_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../service/auth_service.dart';
import '../widget/stamp_card_widget.dart';

class StampManagementPage extends ConsumerStatefulWidget {
  const StampManagementPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StampManagementPageState();
}

class _StampManagementPageState extends ConsumerState<StampManagementPage> {
  Future<ShopsResponse> _fetchShops(String userId) async {
    return await GrpcService.getShops(userId, []);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authServiceProvider.notifier).getCurrentUser();
    final userId = user!.uid;
    return FutureBuilder<ShopsResponse>(
      future: _fetchShops(userId),
      builder: (BuildContext context, AsyncSnapshot<ShopsResponse> snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              // color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'スタンプ獲得数：',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      TextSpan(
                        text:
                            '${data.shops.where((shop) => shop.isStamped == true).length} ',
                        style: TextStyle(color: Colors.black, fontSize: 36),
                      ),
                      TextSpan(
                        text: '/',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      TextSpan(
                        text: ' ${data.shops.length} ',
                        style: TextStyle(color: Colors.black, fontSize: 36),
                      ),
                      TextSpan(
                        text: '個',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: data.shops.length,
                itemBuilder: (context, index) {
                  final shop = data.shops.toList()[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShopDetailPage(
                                year: shop.year,
                                no: shop.no,
                                shopId: shop.iD.toInt(),
                                shopName: shop.shopName,
                                address: shop.address);
                          },
                        ),
                      );
                    },
                    child: StampCard(userId: userId, shop: shop),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
