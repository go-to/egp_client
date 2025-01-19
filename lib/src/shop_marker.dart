import 'package:flutter/material.dart';
import '../app_constants.dart';

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
