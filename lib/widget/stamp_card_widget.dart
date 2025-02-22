import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/config.dart';
import '../grpc_gen/egp.pb.dart';

class StampCard extends StatelessWidget {
  final String userId;
  final Shop shop;

  const StampCard({super.key, required this.userId, required this.shop});

  @override
  Widget build(BuildContext context) {
    final shopName = '${shop.no}: ${shop.shopName}';
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              shopName,
              style: TextStyle(
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: Colors.white.withAlpha(0),
                  child: Center(
                    child: Text(
                      '${shop.no}',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: GoogleFonts.notoSansJp(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ).fontFamily,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                // スタンプ描画
                Stack(
                  children: [
                    for (int i = 0; i < shop.numberOfTimes; i++) ...{
                      paintStamp(userId, shop.iD.toInt(), i)
                    }
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // スタンプ描画
  Widget paintStamp(String userId, int shopId, int index) {
    // 1つめ
    if (index == 0) {
      return Positioned(
        child: Transform.rotate(
          angle: index * 2 * math.pi / 180,
          child: Image.asset(Config.isStampedSelectedImagePath,
              width: 200, height: 200),
        ),
      );
    }

    // 2つめ以降
    return Positioned(
      top: (-10 - 20 * index).toDouble(),
      left: (0 + 20 * index).toDouble(),
      child: Transform.rotate(
        angle: index * 2 * math.pi / 180,
        child: Image.asset(Config.isStampedSelectedImagePath,
            width: 200, height: 200),
      ),
    );
  }
}
