import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../grpc_gen/egp.pb.dart';

class StampCard extends StatelessWidget {
  final Shop shop;

  const StampCard({Key? key, required this.shop}) : super(key: key);

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
                // Image.network(
                //   shop.menuImageUrl,
                //   fit: BoxFit.cover,
                //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                //     if (loadingProgress == null) return child;
                //     return Center(
                //       child: CircularProgressIndicator(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                //             : null,
                //       ),
                //     );
                //   },
                // ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
