import 'dart:async';
import 'dart:core';

import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:egp_client/provider/search_condition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../const/config.dart';
import '../provider/marker_provider.dart';
import '../provider/default_marker_icon_provider.dart';
import '../provider/selected_marker_icon_provider.dart';
import '../provider/shop_provider.dart';
import '../service/shop_service.dart';
import '../view/shop_detail_page.dart';

class ShopListPage extends ConsumerStatefulWidget {
  const ShopListPage({super.key});

  @override
  ConsumerState<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends ConsumerState<ShopListPage> {
  bool _locationPermissionGranted = false;
  bool _mapCreated = false;
  late GoogleMapController _mapController;
  late StreamSubscription<Position>? _positionStream;
  late Map<String, Marker> _markers;
  Position? currentPosition;

  final _pageController = PageController(
    viewportFraction: 0.85,
  );

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: Config.locationDistanceFilter,
  );

  // 初期位置
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(Config.defaultMapLatitude, Config.defaultMapLongitude),
    zoom: Config.defaultMapZoom,
  );

  // 店舗の営業中か否かを識別するためのアイコン
  final shopOpenIcon = AssetMapBitmap(
    Config.shopOpenImagePath,
    width: Config.shopImageWidth,
    height: Config.shopImageHeight,
  );
  final shopCloseIcon = AssetMapBitmap(
    Config.shopCloseImagePath,
    width: Config.shopImageWidth,
    height: Config.shopImageHeight,
  );

  @override
  void initState() {
    super.initState();
    _startPositionStream();
    _markers = {};
    _addMarkers();
  }

  void _addMarkers() async {
    final shops = await ShopService.getShops();
    _setMarkers(shops);
  }

  void _setMarkers(ShopsResponse? shops) async {
    Map<String, Marker> markers = {};
    for (var shop in shops!.shops) {
      final markerId = MarkerId(shop.iD.toString());
      markers[markerId.value] = (Marker(
        markerId: markerId,
        position: LatLng(shop.latitude, shop.longitude),
        onTap: () {
          ref.read(selectedMarkerProvider.notifier).selectMarker(markerId);
        },
        // 営業時間中か否かによって表示するアイコンを変える
        icon: shop.inCurrentSales ? shopOpenIcon : shopCloseIcon,
        zIndex: shop.inCurrentSales ? 1.toDouble() : 0.toDouble(),
      ));
    }

    setState(() {
      _markers = markers;
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    _pageController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // 現在地ストリームを開始
  void _startPositionStream() async {
    final permissionGranted = await _checkLocationPermission();
    if (!permissionGranted) return;

    // 権限が許可された場合にGoogleMapを再ビルド
    if (permissionGranted) {
      setState(() {
        _locationPermissionGranted = true;
      });
      _positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position position) {
          // カメラを現在地に移動
          if (!_mapCreated) {
            CircularProgressIndicator();
          } else {
            _mapController.animateCamera(
              CameraUpdate.newLatLng(_kGooglePlex.target),
            );
          }
          setState(() {});
        },
        onError: (e) {
          print('位置情報取得エラー: $e');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // マーカーリストを取得
    final selectedMarkerId = ref.watch(selectedMarkerProvider);
    // 選択中のマーカーID
    final shopListAsync = ref.watch(shopProvider);
    // アイコンを取得（非同期）
    final defaultIconOpenAsync = ref.watch(defaultMarkerIconOpenProvider);
    final defaultIconCloseAsync = ref.watch(defaultMarkerIconCloseProvider);
    final selectedIconAsync = ref.watch(selectedMarkerIconProvider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // マップ表示
        shopListAsync.when(
          data: (shops) {
            return defaultIconOpenAsync.when(
              data: (defaultIconOpen) {
                return defaultIconCloseAsync.when(
                  data: (defaultIconClose) {
                    return selectedIconAsync.when(
                      data: (selectedIcon) {
                        if (_locationPermissionGranted) {
                          // マーカーアイコンを設定
                          final markers = shops!.shops.map((shop) {
                            final marker = _markers[shop.iD.toString()] ??
                                Marker(markerId: MarkerId(shop.iD.toString()));
                            var icon = defaultIconOpen;
                            var zIndex = 1;
                            if (marker.markerId == selectedMarkerId) {
                              icon = selectedIcon;
                              zIndex = 2;
                            } else if (!shop.inCurrentSales) {
                              icon = defaultIconClose;
                              zIndex = 0;
                            }
                            return marker.copyWith(
                              iconParam: icon,
                              zIndexParam: zIndex.toDouble(),
                              onTapParam: () {
                                ref
                                    .read(selectedMarkerProvider.notifier)
                                    .selectMarker(marker.markerId);
                              },
                            );
                          }).toSet();

                          return Stack(
                            children: [
                              GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: _kGooglePlex,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                                onMapCreated: (GoogleMapController controller) {
                                  _mapController = controller;
                                  setState(() {
                                    _mapCreated = true;
                                  });
                                },
                                onTap: (LatLng position) async {
                                  ref
                                      .read(selectedMarkerProvider.notifier)
                                      .clearSelection();
                                },
                                markers: markers,
                              ),
                              if (!_mapCreated)
                                const Center(
                                    child: CircularProgressIndicator()),
                            ],
                          );
                        } else {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                final permissionGranted =
                                    await _checkLocationPermission();

                                // 権限が許可された場合にGoogleMapを再ビルド
                                if (permissionGranted) {
                                  setState(() {
                                    _locationPermissionGranted = true;
                                  });
                                }
                              },
                              child: Text('位置情報を許可する'),
                            ),
                          );
                        }
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (Object error, StackTrace stackTrace) => Center(
                        child: Text('Error: $error'),
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (Object error, StackTrace stackTrace) => Center(
                    child: Text('Error: $error'),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (Object error, StackTrace stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        ),

        // 検索条件
        shopListAsync.when(
          data: (shops) {
            final searchCondition = ref.watch(searchConditionProvider);
            final searchItemList =
                ref.watch(searchConditionProvider.notifier).getSearchItemList();
            return Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.0,
                    runSpacing: 0.0,
                    children: [
                      for (final MapEntry(:key, :value)
                          in searchItemList.entries) ...{
                        _buildSearchTypeButton(
                            ref, key, value, searchCondition),
                      },
                    ],
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        ),

        // カード表示
        shopListAsync.when(
          data: (shops) {
            if (_locationPermissionGranted) {
              // マーカー未選択の場合は非表示
              if (selectedMarkerId == null) {
                return const SizedBox.shrink();
              }

              // 選択中のマーカーに該当するIndexを取得
              final selectedIndex = _markers.values
                  .toList()
                  .indexWhere((m) => m.markerId == selectedMarkerId);
              if (selectedIndex != -1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // PageViewがビルドされた後にジャンプ
                  if (_pageController.hasClients) {
                    _pageController.jumpToPage(selectedIndex);
                  }
                });
              }

              return Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _markers.length,
                  onPageChanged: (index) async {
                    ref
                        .read(selectedMarkerProvider.notifier)
                        .selectMarker(_markers.values.toList()[index].markerId);

                    //現在のズームレベルを取得
                    final zoomLevel = await _mapController.getZoomLevel();
                    final shop = shops!.shops[index];

                    //スワイプ後のお店の座標までカメラを移動
                    _mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(shop.latitude, shop.longitude),
                          zoom: zoomLevel,
                        ),
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final shop = shops!.shops[index];
                    final attributes = {
                      'メニュー名': shop.menuName,
                      '住所': shop.address,
                      '提供時間': shop.businessHours,
                    };
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                final shop = shops.shops.elementAt(index);
                                return ShopDetailPage(
                                    year: shop.year,
                                    no: shop.no,
                                    shopName: shop.shopName,
                                    address: shop.address);
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  '${shop.no}: ${shop.shopName}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 8),
                                  Expanded(
                                    flex: 1,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 100,
                                        maxHeight: 100,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          shop.menuImageUrl,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.error);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            attributes.entries.map((entry) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 4),
                                            child: Text(
                                              '${entry.key}: ${entry.value}',
                                              // style: TextStyle(fontSize: 14),
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stackTrace) => Center(
            child: Text('Error: $error'),
          ),
        ),

        // 現在地ボタン
        _locationPermissionGranted
            ? Positioned(
                right: Config.currentPositionButtonPositionRight,
                bottom: Config.currentPositionButtonPositionBottom,
                child: _goToCurrentPositionButton(),
              )
            : Container(),
      ],
    );
  }

  // 検索条件更新Widget
  Widget _buildSearchTypeButton(
      WidgetRef ref, int searchKey, String label, Set<int> selectedKeys) {
    return ElevatedButton(
      onPressed: () async {
        // ボタンの状態を更新
        final searchCondition = ref
            .read(searchConditionProvider.notifier)
            .setSearchCondition(searchKey);
        // 店舗情報を取得
        final shops =
            await ref.read(shopProvider.notifier).getShops(searchCondition);
        // マーカー情報を更新
        _setMarkers(shops);
        // マーカーの選択状態を解除
        ref.read(selectedMarkerProvider.notifier).clearSelection();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedKeys.contains(searchKey) ? Colors.yellow : null,
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight:
                  selectedKeys.contains(searchKey) ? FontWeight.bold : null)),
    );
  }

  // 現在値ボタンWidget
  Widget _goToCurrentPositionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(Config.currentPositionButtonWidth,
            Config.currentPositionButtonHeight),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
      ),
      onPressed: () async {
        final permissionGranted = await _checkLocationPermission();
        if (!permissionGranted) return;

        // 権限が許可された場合にGoogleMapを再ビルド
        if (permissionGranted) {
          setState(() {
            _locationPermissionGranted = true;
          });
        }

        // 現在位置に移動
        final position = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings);
        final currentLatLng = LatLng(position.latitude, position.longitude);
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(currentLatLng, Config.defaultMapZoom),
        );
      },
      child: const Icon(Icons.my_location_outlined),
    );
  }

  // 位置情報の権限を確認
  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 位置情報サービスが有効か確認
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('位置情報サービスを有効にしてください。')),
      );
      return false;
    }

    // 位置情報の権限を確認
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('位置情報の権限が拒否されました。')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('位置情報の権限が永久に拒否されています。')),
      );
      return false;
    }

    return true;
  }
}
