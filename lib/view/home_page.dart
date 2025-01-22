import 'dart:async';

import 'package:egp_client/grpc_gen/egp.pb.dart';
import 'package:egp_client/provider/shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../const/config.dart';
import '../provider/marker_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _locationPermissionGranted = false;
  late GoogleMapController _mapController;
  late StreamSubscription<Position>? _positionStream;
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

  @override
  void initState() {
    super.initState();
    _startPositionStream();

    // デフォルトのマーカー表示
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shops = await ref.read(shopProvider.notifier).setShops();
      ref
          .read(markerProvider.notifier)
          .addDefaultMarkers(_pageController, shops);
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
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
    }

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        // カメラを現在地に移動
        _mapController.animateCamera(
          CameraUpdate.newLatLng(_kGooglePlex.target),
        );
      },
      onError: (e) {
        print('位置情報取得エラー: $e');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shops = ref.watch(shopProvider);
    final markers = ref.watch(markerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Config.appTitle),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _locationPermissionGranted
              ? GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  markers: markers.values.toSet(),
                )
              : Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      // _checkLocationPermission;
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
                ),
          _locationPermissionGranted
              ? Container(
                  height: 148,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: PageView(
                    onPageChanged: (int index) async {
                      //スワイプ後のページのお店を取得
                      final selectedShop = shops.values.elementAt(index);
                      var activeShopId = '';
                      var selectedShopPosition =
                          LatLng(selectedShop.latitude, selectedShop.longitude);
                      for (var marker in markers.values) {
                        if (marker.position == selectedShopPosition) {
                          activeShopId = marker.markerId.value.toString();
                          break;
                        }
                      }
                      ref
                          .read(markerProvider.notifier)
                          .updateMarkers(_pageController, shops, activeShopId);
                      //現在のズームレベルを取得
                      final zoomLevel = await _mapController.getZoomLevel();
                      //スワイプ後のお店の座標までカメラを移動
                      _mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(
                                selectedShop.latitude, selectedShop.longitude),
                            zoom: zoomLevel,
                          ),
                        ),
                      );
                    },
                    controller: _pageController,
                    children: _shopTiles(shops),
                  ),
                )
              : Container(),
          _locationPermissionGranted
              ? Positioned(
                  right: Config.currentPositionButtonPositionRight,
                  bottom: Config.currentPositionButtonPositionBottom,
                  child: _goToCurrentPositionButton(),
                )
              : Container(),
        ],
      ),
    );
  }

  // カード
  List<Widget> _shopTiles(Map<String, Shop> shops) {
    final shopTiles = shops.values.map(
      (shop) {
        return Card(
          child: SizedBox(
            height: 100,
            child: Center(
              child: Text('${shop.no}: ${shop.shopName}'),
            ),
          ),
        );
      },
    ).toList();
    return shopTiles;
  }

  // 現在値ボタン
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

        // 店舗情報を更新
        Future.delayed(Duration(seconds: 0), () async {
          final shops = await ref.read(shopProvider.notifier).setShops();
          ref
              .read(markerProvider.notifier)
              .updateMarkers(_pageController, shops);
        });
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
