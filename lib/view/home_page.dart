import 'dart:async';

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
  late GoogleMapController _controller;
  late StreamSubscription<Position> positionStream;
  Position? currentPosition;

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

    // 位置情報が許可されていない時に許可をリクエストする
    Future(() async {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
    });

    // 現在位置を更新し続ける
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      currentPosition = position;
    });

    // デフォルトのマーカー表示
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(markerProvider.notifier).addDefaultMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final markers = ref.watch(markerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Config.appTitle),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: markers,
          ),
          Positioned(
            right: Config.currentPositionButtonPositionRight,
            bottom: Config.currentPositionButtonPositionBottom,
            child: _goToCurrentPositionButton(),
          ),
        ],
      ),
    );
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
        Position currentPosition = await Geolocator.getCurrentPosition(
            locationSettings: locationSettings);
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target:
                    LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: Config.defaultMapZoom),
          ),
        );
        // 店舗情報を更新
        ref.read(markerProvider.notifier).updateMarkers();
      },
      child: const Icon(Icons.my_location_outlined),
    );
  }
}
