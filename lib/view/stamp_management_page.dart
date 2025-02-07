import 'package:egp_client/provider/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StampManagementPage extends ConsumerStatefulWidget {
  const StampManagementPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StampManagementPageState();
}

class _StampManagementPageState extends ConsumerState<StampManagementPage> {
  @override
  Widget build(BuildContext context) {
    final shopListAsync = ref.watch(shopProvider);

    return shopListAsync.when(
      data: (shops) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: shops!.shops.length, // 仮のスタンプ数
          itemBuilder: (context, index) {
            final shop = shops.shops.toList()[index];
            return Card(
              child: Center(
                child: Text('${shop.no}: ${shop.shopName}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) => Center(
        child: Text('Error: $error'),
      ),
    );
  }
}
