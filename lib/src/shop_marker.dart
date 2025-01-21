import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class ShopMarker extends StatelessWidget {
  final String shopName;
  final bool inCurrentSales;

  const ShopMarker({
    super.key,
    required this.shopName,
    required this.inCurrentSales,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: AssetImage(
            // TODO タップした店舗の写真を表示
            inCurrentSales ? 'assets/test.png' : 'assets/test.png',
          ),
          height: 150,
          width: 150,
        ),
        Text(
          shopName,
          style: const TextStyle(color: Colors.black),
        )
      ],
    );
  }
}

Future<BitmapDescriptor> createShopMarker(shopName, inCurrentSales) async {
  final shopMarker = ShopMarker(
    shopName: shopName,
    inCurrentSales: inCurrentSales,
  );

  final result = await shopMarker.toBitmapDescriptor(
      logicalSize: const Size(150, 150), imageSize: const Size(300, 400));
  return result;
}
