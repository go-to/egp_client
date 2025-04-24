import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../const/config.dart';

class ShopMarkerWidget extends StatelessWidget {
  final String shopName;
  final bool inCurrentSales;

  const ShopMarkerWidget(
      {super.key, required this.shopName, required this.inCurrentSales});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          image: AssetImage(
            Config.shopSelectedImagePath,
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

Future<BitmapDescriptor> createShopMarkerWidget(
    shopName, inCurrentSales) async {
  final shopMarkerWidget = ShopMarkerWidget(
    shopName: shopName,
    inCurrentSales: inCurrentSales,
  );

  final result = await shopMarkerWidget.toBitmapDescriptor(
      // logicalSize: const Size(150, 150), imageSize: const Size(300, 400));
      logicalSize: const Size(100, 100),
      imageSize: const Size(200, 400));
  return result;
}
